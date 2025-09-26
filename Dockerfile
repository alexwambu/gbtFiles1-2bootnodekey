# Bootnode Dockerfile for GBTNetwork
FROM ethereum/client-go:stable

WORKDIR /app

# Ensure bootnode.key exists at build (optional safeguard)
RUN bootnode -genkey /app/bootnode.key || true

COPY run_bootnode.sh /app/run_bootnode.sh
RUN chmod +x /app/run_bootnode.sh

EXPOSE 30301/udp
EXPOSE 30301/tcp

CMD ["./run_bootnode.sh"]
