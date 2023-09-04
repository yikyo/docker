FROM golang:1.21.0-alpine3.18 as builder

ARG CGO_ENABLED=0 VERSION

RUN apk add --no-cache git && \
    git clone --single-branch --depth 1 -b $VERSION https://github.com/IrineSistiana/mosdns.git /source && \
    cd /source && \
    go build -trimpath -ldflags "-s -w" -o mosdns



FROM alpine:latest

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

VOLUME ["/etc/.mosdns.d"]

COPY --from=builder /source/mosdns /usr/local/bin/mosdns

RUN apk add --no-cache ca-certificates

ENTRYPOINT ["/usr/local/bin/mosdns", "start", "-d", "/etc/.mosdns.d"]