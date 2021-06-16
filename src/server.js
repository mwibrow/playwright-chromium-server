const { chromium } = require('playwright');
const http = require('http');
const httpProxy = require('http-proxy');

const config = require('./config');

(async () => {
  const browserServer = await chromium.launchServer({ port: config.SERVER_PORT });
  const wsEndpoint = browserServer.wsEndpoint();
  const proxy = httpProxy.createServer({
    target: wsEndpoint,
    ws: true,
    changeOrigin: true,
    ignorePath: true,
  });

  server = http.createServer();
  server.on('upgrade', (req, socket, head) => {
    proxy.ws(req, socket, head);
  });

  server.listen(config.PLAYWRIGHT_PORT);
})();
