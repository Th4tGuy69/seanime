FROM alpine

ARG APP_YML_URL=https://github.com/5rahim/seanime/releases/latest/download/latest.yml

WORKDIR /tmp

RUN apk add --no-cache curl tar grep && \
    #
    curl -L -o latest.yml ${APP_YML_URL} && \
    VERSION=$(grep '^version:' latest.yml | cut -d':' -f2 | xargs) && \
    #
    curl -L -o seanime.tar.gz \
    "https://github.com/5rahim/seanime/releases/download/v${VERSION}/seanime-${VERSION}_Linux_x86_64.tar.gz" && \
    tar -xzf seanime.tar.gz && \
    mv seanime /seanime && \
    #
    rm -rf /tmp/* && \
    apk del curl tar grep && \
    #
    mkdir -p /root/.config && \
    ln -s /config /root/.config/Seanime

ENV SEANIME_SERVER_HOST="0.0.0.0"

EXPOSE 43211

ENTRYPOINT ["/seanime"]
