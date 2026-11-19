# SparkyMusic Lavalink node

A separate Railway service for the SparkyMusic Discord bot. It uses the official Lavalink v4 Alpine container and loads YouTube Source, LavaSrc, and LavaLyrics plugins.

## Files
- `Dockerfile` — builds from the official Lavalink image.
- `application.yml` — Lavalink and plugin configuration.

## Railway deployment
1. Create a GitHub repository named `SparkyMusic-Lavalink`.
2. Upload these three files to the repository root.
3. In the same Railway project/environment as the bot, add a new service from this GitHub repository.
4. Name the service `Lavalink`.
5. Add variables:
   - `LAVALINK_SERVER_PASSWORD` = a long random password (keep private)
   - `JAVA_TOOL_OPTIONS` = `-Xms256M -Xmx1024M`
6. Deploy. The Dockerfile is detected automatically.
7. Do not create a public HTTP domain or TCP proxy for normal bot-to-node traffic. Use Railway private networking.
8. In the SparkyMusic service, set:
   - `LAVALINK_HOST` = `${{Lavalink.RAILWAY_PRIVATE_DOMAIN}}`
   - `LAVALINK_PORT` = `2333`
   - `LAVALINK_PASSWORD` = `${{Lavalink.LAVALINK_SERVER_PASSWORD}}`
   - `LAVALINK_SECURE` = `false`

Both services must be in the same Railway project and environment. The Lavalink service must listen on port 2333. No public TCP proxy is needed for private service-to-service traffic.

## Notes
- The config enables YouTube search/playback and YouTube/LRCLIB lyric providers. Plugin versions are pinned in `application.yml`.
- Spotify and Apple Music source adapters are initially disabled. LavaSrc can mirror metadata to playable sources, but Spotify/Apple Music credentials and provider configuration may be required to enable them.
- A YouTube source plugin can still be rate-limited or temporarily blocked by YouTube. No source is guaranteed to work indefinitely.
- This service consumes Railway compute and is billed according to the Railway plan/usage. It is not a free unlimited music host.
