# Bootnode Dockerfile for GBTNetwork
FROM ethereum/client-go:stable

WORKDIR /app

# Generate bootnode.key at build time (safe guard)
RUN bootnode -genkey /app/bootnode.key || true

COPY run_bootnode.sh /app/run_bootnode.sh
RUN chmod +x /app/run_bootnode.sh

EXPOSE 30301/udp
EXPOSE 30301/tcp

# Use absolute path, not relative
CMD ["/bin/sh", "/app/run_bootnode.sh"]
