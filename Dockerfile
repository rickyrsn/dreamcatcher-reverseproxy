# Use the official Caddy v2 base image
FROM caddy:2.6.4-builder AS builder
RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM caddy:2.6.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
ARG cloudflare
ENV cloudflare $cloudflare

# Set environment variables
ENV CADDYPATH /etc/caddy/.caddy

# Copy Caddyfile to the container
COPY Caddyfile /etc/caddy/Caddyfile

# Expose the HTTP and HTTPS ports
EXPOSE 80 443

# Start Caddy with the provided Caddyfile
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
