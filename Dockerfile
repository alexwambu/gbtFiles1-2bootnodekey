# GBTNetwork Bootnode Dockerfile with static-nodes.json output
FROM ethereum/client-go:stable

WORKDIR /app

# Copy helper script
COPY run_bootnode.sh ./run_bootnode.sh

# Ensure script is executable
RUN chmod +x ./run_bootnode.sh

# Expose discovery ports
EXPOSE 30301/tcp
EXPOSE 30301/udp

ENTRYPOINT ["./run_bootnode.sh"]
