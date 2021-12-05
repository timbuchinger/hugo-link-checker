FROM golang:alpine3.15
# 1.12.7-alpine3.10
ENV HUGO_VERSION='0.89.4-r0'
ENV HUGO_FILE_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"

LABEL "com.github.actions.name"="hugo-link-checker"
LABEL "com.github.actions.description"="Serves the site with Hugo and then run muffet to check for broken links."
LABEL "com.github.actions.icon"="stop-circle"
LABEL "com.github.actions.color"="gray-dark"
LABEL "repository"="https://github.com/timbuchinger/hugo-link-checker"
LABEL "homepage"="https://github.com/timbuchinger/hugo-link-checker"
LABEL "maintainer"="Tim Buchinger"

# RUN wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_FILE_NAME}.tar.gz" && \
#     tar -zxvf "${HUGO_FILE_NAME}.tar.gz" && \
#     mv ./hugo /go/bin/ && \
RUN apk --update add git "hugo=${HUGO_VERSION}" curl && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/* && \
    GO111MODULE=on go install github.com/raviqqe/muffet/v2@v2.4.7

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]