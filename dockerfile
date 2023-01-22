FROM alpine:3.17.1 

LABEL maintainer="yiKyo <yikyo666@gmail.com>"

ARG TARGETOS

ARG TARGETARCH

ENV CLASH_META_VERSION=v1.14.1

EXPOSE 7890 9090

RUN apk add --update curl gzip \
    && rm -rf /var/cache/apk/*

RUN curl -LO https://github.com/MetaCubeX/Clash.Meta/releases/download/${CLASH_META_VERSION}/clash.meta-${TARGETOS}-${TARGETARCH}-${CLASH_META_VERSION}.gz \
    && gunzip clash.meta-${TARGETOS}-${TARGETARCH}-${CLASH_META_VERSION}.gz \
    && mv clash.meta-${TARGETOS}-${TARGETARCH}-${CLASH_META_VERSION} /usr/local/bin/clash.meta \
    && chmod +x /usr/local/bin/clash.meta

ENTRYPOINT ["/usr/local/bin/clash.meta", "-d", "/etc/.clash.meta.d/config.yaml"]
