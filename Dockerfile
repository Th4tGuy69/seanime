FROM alpine

ARG SEANIME_VERSION

WORKDIR /tmp

RUN apk add --no-cache curl tar && \
    #
    curl -L -o seanime.tar.gz \
    "https://github.com/5rahim/seanime/releases/download/${SEANIME_VERSION}/seanime-${SEANIME_VERSION#v}_Linux_x86_64.tar.gz" && \
    tar -xzf seanime.tar.gz && \
    mv seanime /seanime && \
    #
    rm -rf /tmp/* && \
    apk del curl tar && \
    #
    mkdir -p /root/.config && \
    ln -s /config /root/.config/Seanime

ENV SEANIME_SERVER_HOST="0.0.0.0"

EXPOSE 43211

ENTRYPOINT ["/seanime"]
