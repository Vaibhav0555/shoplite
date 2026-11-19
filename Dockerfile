FROM node:22-alpine@sha256:1314fb30ec37592d5845e5a160d522c0e680972aa534549940b8d73bde88481a

LABEL org.opencontainers.image.title="ShopLite API" \
      org.opencontainers.image.version="5.0.0" \
      org.opencontainers.image.authors="Vaibhav Singh" \
      org.opencontainers.image.source="https://github.com/Vaibhav0555/shoplite"

ENV NODE_ENV=production

WORKDIR /app

COPY  --chown=1000:1000 products.json server.js /app/

USER 1000:1000

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["wget", "-qO-", "http://localhost:3000/health"]

CMD ["node", "server.js"]