FROM golang:1.21.1-alpine3.18 as builder

ARG CGO_ENABLED=0 VERSION

RUN apk add --no-cache git && \
    git clone --single-branch --depth 1 -b $VERSION https://github.com/IrineSistiana/mosdns.git /source && \
    git clone --single-branch --depth 1 https://github.com/sbwml/luci-app-mosdns.git /patches && \
    cd /source && \
    git apply /patches/mosdns/patches/*.patch && \
    go build -trimpath -ldflags "-s -w" -o mosdns



FROM alpine:3.18.3

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

ENV TZ="Asia/Shanghai"

VOLUME ["/etc/.mosdns.d"]

COPY --from=builder /source/mosdns /usr/local/bin/mosdns

RUN apk add --no-cache ca-certificates tzdata

ENTRYPOINT ["/usr/local/bin/mosdns", "start", "-d", "/etc/.mosdns.d"]