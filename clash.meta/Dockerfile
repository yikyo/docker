FROM golang:alpine as builder

ARG VERSION

RUN apk add --no-cache git && \
    git clone --single-branch --depth 1 -b $VERSION https://github.com/MetaCubeX/Clash.Meta.git /clash && \
    cd /clash && \
    go build -tags with_gvisor -ldflags "-s -w" -o clash && \
    mkdir /clash-config && \
    cd /clash-config && \
    wget -O geoip.metadb https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.metadb && \
    wget -O geosite.dat https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geosite.dat && \
    wget -O geoip.dat https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.dat

FROM alpine:latest

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

VOLUME ["/etc/.clash.meta.d"]

EXPOSE 7890 9090

COPY --from=builder /clash-config /etc/.clash.meta.d

COPY --from=builder /clash/clash /usr/local/bin/clash

RUN apk add --no-cache ca-certificates tzdata iptables && \
    chmod +x /usr/local/bin/clash

ENTRYPOINT ["/usr/local/bin/clash", "-d", "/etc/.clash.meta.d"]


