# Bootnode Dockerfile
FROM ethereum/client-go:stable

WORKDIR /app

# Generate the bootnode key if missing
RUN bootnode -genkey /app/bootnode.key || true

COPY run_bootnode.sh /app/run_bootnode.sh
RUN chmod +x /app/run_bootnode.sh

EXPOSE 30301/udp
EXPOSE 30301/tcp

CMD ["./run_bootnode.sh"]
