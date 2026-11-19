FROM nginx:alpine@sha256:0563c36f94a6d3ec3584161b77859f740f7e20b4853f52c796a864ce6908e8ea

LABEL org.opencontainers.image.title="ShopLite Frontend" \
      org.opencontainers.image.version="5.0.0" \
      org.opencontainers.image.authors="Vaibhav Singh" \
      org.opencontainers.image.source="https://github.com/Vaibhav0555/shoplite"

COPY index.html /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["wget", "-qO-", "http://localhost/"]
