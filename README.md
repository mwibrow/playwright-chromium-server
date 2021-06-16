# 🎭 playwright-chromium-server

This repo contains an example of running a [Playwright](https://playwright.dev/)
server.

## Usage

Run the following command at the project root:

```
docker-compose up -d build playwright-server
```

This will build a container and expose port `8164`.
Additonally a custom network called `server` will be se up.
If the port or network is already in use, edit the 
`docker-compose.yml` file.
