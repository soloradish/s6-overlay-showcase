FROM golang:1.20.5 as builder
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 go build -o /app/s6-overlay-showcase


FROM alpine:latest
ARG S6_OVERLAY_VERSION=3.1.5.0
ARG TARGETARCH

RUN apk add xz   
COPY --from=builder /app/s6-overlay-showcase /app/s6-overlay-showcase

COPY s6/simple-with-env/run /etc/services.d/s6-overlay-showcase/run
COPY s6/env /env

VOLUME ["/env"]
RUN wget "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz" -O "/tmp/s6-overlay-noarch.tar.xz" && \
    tar -C / -Jxpf "/tmp/s6-overlay-noarch.tar.xz" && \
    rm -f "/tmp/s6-overlay-noarch.tar.xz"
RUN [ "${TARGETARCH}" == "arm64" ] && FILE="s6-overlay-aarch64.tar.xz" || FILE="s6-overlay-x86_64.tar.xz"; \
    wget "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/${FILE}" -O "/tmp/${FILE}" && \
    tar -C / -Jxpf "/tmp/${FILE}" && \
    rm -f "/tmp/${FILE}"
ENTRYPOINT ["/init"]
