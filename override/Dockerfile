FROM golang:1.21.1-alpine3.18 AS builder

ARG CGO_ENABLED=0 VERSION

RUN apk add --no-cache git && \
    git clone --single-branch --depth 1 -b $VERSION https://github.com/linux-do/override.git /source && \
    cd /source && \
    go mod download && \
    go build -ldflags="-w -s" -o override


FROM alpine:3.18.3

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

ENV TZ="Asia/Shanghai"

WORKDIR /app

VOLUME ["/app"]

EXPOSE 8181

COPY --from=builder /source/override /usr/local/bin/override

COPY --from=builder /source/config.json.example /app/config.json

RUN apk add --no-cache ca-certificates tzdata

ENTRYPOINT ["override"]