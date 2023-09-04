FROM golang:1.21.0-alpine3.18 as builder

ARG CGO_ENABLED=0 VERSION

RUN apk add --no-cache git && \
    git clone --single-branch --depth 1 -b $VERSION https://github.com/MetaCubeX/Clash.Meta.git /source && \
    cd /source && \
    go build -tags with_gvisor -trimpath -ldflags "-s -w" -o clash


FROM alpine:3.18.3

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

VOLUME ["/etc/.clash.meta.d"]

EXPOSE 7890 9090

COPY --from=builder /source/clash /usr/local/bin/clash

RUN apk add --no-cache ca-certificates tzdata iptables && \
    chmod +x /usr/local/bin/clash

ENTRYPOINT ["/usr/local/bin/clash", "-d", "/etc/.clash.meta.d"]