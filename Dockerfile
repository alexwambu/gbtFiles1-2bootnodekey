# GBTNetwork Bootnode Dockerfile
FROM ethereum/client-go:stable

WORKDIR /app

# Copy bootnode key if present (optional)
COPY bootnode.key ./bootnode.key

# Expose discovery ports
EXPOSE 30301/tcp
EXPOSE 30301/udp

# Run bootnode (generate a key if missing)
CMD ["/bin/sh", "-c", "if [ ! -f bootnode.key ]; then bootnode -genkey bootnode.key; fi && bootnode -nodekey bootnode.key -addr :30301"]

