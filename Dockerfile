FROM gliderlabs/alpine

MAINTAINER Doug Tangren <d.tangren@gmail.com>

ENV RUST_VERSION 2015-04-19
ENV RUST_GZ rust-nightly-x86_64-unknown-linux-gnu.tar.gz
ENV RUST_URL https://static.rust-lang.org/dist/$RUST_VERSION/$RUST_GZ
ENV RUST_DIR rust-nightly-x86_64-unknown-linux-gnu

RUN \
  apk update \
  && apk add curl \
  && echo "downloading rust" \
  && curl -SLO $RUST_URL \
  && tar -xvzf $RUST_GZ \
  && $RUST_DIR/install.sh \
  && rm -r $RUST_GZ $RUST_DIR

RUN echo "downloading docker" \
  && curl https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker \
  && chmod +x /usr/bin/docker

VOLUME /src
WORKDIR /src

COPY build.sh /

ENTRYPOINT ["/build.sh"]