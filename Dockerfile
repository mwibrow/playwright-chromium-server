FROM ubuntu:focal

# Adapted from https://github.com/microsoft/playwright/blob/master/utils/docker/Dockerfile.focal

ARG PLAYWRIGHT_BROWSERS_PATH=/playwright-browsers
ARG TMP_WKDIR=/tmp-wkdir

# Install node16
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils curl  && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Bake chromium drivers into image
RUN echo "update-notifier=false" > ~/.npmrc
RUN mkdir -p "$TMP_WKDIR"
WORKDIR "$TMP_WKDIR"
ENV PLAYWRIGHT_BROWSERS_PATH="$PLAYWRIGHT_BROWSERS_PATH"
RUN npm install --global playwright-chromium
RUN mkdir -p "$PLAYWRIGHT_BROWSERS_PATH" && \
    npx playwright install-deps chromium

# Clean up
RUN npm uninstall playwrgiht-chromium
RUN chmod -R 777 "$PLAYWRIGHT_BROWSERS_PATH"
RUN rm -R "$TMP_WKDIR"

# Make sure there is a /tmp dir that can be accessed
RUN mkdir -p /tmp && chmod -R 777 /tmp

# Add user 
RUN adduser --system app
RUN mkdir -p /usr/src/app
RUN chown app /usr/src/app
WORKDIR /usr/src/app

USER app
COPY src /usr/src/app/src
COPY package.json package-lock.json /usr/src/app/
RUN echo "update-notifier=false" > ~/.npmrc
RUN PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 && npm ci

EXPOSE 8164