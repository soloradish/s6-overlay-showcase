# Use your favorite image
FROM alpine:latest
ARG S6_OVERLAY_VERSION=3.1.5.0
ARG ARCH

RUN apk add xz   
COPY .targets/s6-overlay-showcase /app/s6-overlay-showcase
COPY s6/simple-with-env/run /etc/services.d/s6-overlay-showcase/run
COPY s6/env /env

VOLUME ["/env"]

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${ARCH}.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-${ARCH}.tar.xz
ENTRYPOINT ["/init"]
