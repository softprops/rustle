FROM gliderlabs/alpine:3.1

MAINTAINER Doug Tangren <d.tangren@gmail.com>

ENV RUST_VERSION 2015-04-19
ENV RUST_URL https://static.rust-lang.org/dist/$RUST_VERSION/rust-nightly-x86_64-unknown-linux-gnu.tar.gz
ENV RUST_DIR rust-nightly-x86_64-unknown-linux-gnu

RUN \
  apk update \
  && apk add curl \
  && echo "downloading rust" \
  && curl $RUST_URL | tar xvz \
  && $RUST_DIR/install.sh \
  && rm -r $RUST_DIR

RUN echo "downloading docker" \
  && curl https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker \
  && chmod +x /usr/bin/docker

VOLUME /src
WORKDIR /src

COPY build.sh /

ENTRYPOINT ["/build.sh"]