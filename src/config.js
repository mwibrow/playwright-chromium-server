const env = process.env;

const config = Object.freeze({
  PLAYWRIGHT_PORT: parseInt(env.PLAYWRIGHT_PORT),
  SERVER_PORT: parseInt(env.SERVER_PORT),
});

module.exports = config;
