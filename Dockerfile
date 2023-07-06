# Use the official Caddy v2 base image
FROM caddy:2.4.0-alpine

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
