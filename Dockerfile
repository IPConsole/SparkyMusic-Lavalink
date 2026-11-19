FROM ghcr.io/lavalink-devs/lavalink:4-alpine

# Lavalink's official image reads its configuration from this location.
COPY application.yml /opt/Lavalink/application.yml
