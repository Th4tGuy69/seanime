FROM alpine

ARG APP_JSON_URL=https://github.com/5rahim/seanime/releases/latest/download/latest.json

WORKDIR /tmp

RUN apk add --no-cache curl jq tar && \
    #
    curl -L -o latest.json ${APP_JSON_URL} && \
    VERSION=$(jq -r '.version' latest.json) && \
    #
    curl -L -o seanime.tar.gz \
    "https://github.com/5rahim/seanime/releases/download/v${VERSION}/seanime-${VERSION}_Linux_x86_64.tar.gz" && \
    tar -xzf seanime.tar.gz && \
    mv seanime /seanime && \
    #
    rm -rf /tmp/* && \
    apk del curl jq tar && \
    #
    mkdir -p /root/.config && \
    ln -s /config /root/.config/Seanime

ENV SEANIME_SERVER_HOST="0.0.0.0"

EXPOSE 43211

ENTRYPOINT ["/seanime"]
