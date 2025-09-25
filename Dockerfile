# GBTNetwork Bootnode Dockerfile (flat for Render)
FROM ethereum/client-go:stable

WORKDIR /app

# Copy bootnode key if available (optional)
COPY bootnode.key ./bootnode.key

# Expose discovery ports
EXPOSE 30301/tcp
EXPOSE 30301/udp

# Run bootnode
ENTRYPOINT ["bootnode"]
CMD ["-nodekey", "bootnode.key", "-addr", ":30301"]
