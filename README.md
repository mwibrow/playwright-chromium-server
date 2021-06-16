# 🎭 playwright-chromium-server

This repo contains an example of running a [Playwright](https://playwright.dev/)
server.

## Motivation

When running the Playwright server a random (currently) non-configurable web-socket endpoint
is created. This is not particularly helpful when running a cluster
and makes letting clients know the correct endpoint a real nuisance.

This repository takes a simple approach by running the Playwright server
on the same machine as a basic node server with a known endpoint.
This server forwards web-socket connections to the correct endpoint 
for the Playright server.
## Usage

Run the following command at the project root:

```
docker-compose up -d build playwright-server
```

This will build a container and expose port `8164`.
Additonally a custom network called `server` will be se up.
If the port or network is already in use, edit the 
`docker-compose.yml` file.
