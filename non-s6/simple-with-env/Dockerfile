FROM golang:1.20.5 as builder
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 go build -o /app/s6-overlay-showcase


FROM alpine:latest

ENV C_ENV THIS_SHOW_BE_OVERRIDABLE

COPY --from=builder /app/s6-overlay-showcase /app/s6-overlay-showcase
COPY non-s6/simple-with-env/entrypoint.sh /entrypoint.sh
COPY non-s6/env/.env /env/.env

CMD /app/s6-overlay-showcase
ENTRYPOINT ["/entrypoint.sh"]
