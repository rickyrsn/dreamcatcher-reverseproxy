# Use the official Caddy v2 base image
FROM caddy:2.4.0-alpine

RUN apk add --no-cache openssl

# Set environment variables
ENV CADDYPATH /etc/caddy/.caddy

# Copy Caddyfile to the container
COPY Caddyfile.encrypted /etc/caddy/Caddyfile

RUN openssl aes-256-cbc -d -a -in Caddyfile.encrypted -out Caddyfile -pass "pass:$PASSPHRASE"

# Expose the HTTP and HTTPS ports
EXPOSE 80 443

# Start Caddy with the provided Caddyfile
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
