FROM ethereum/client-go:stable

WORKDIR /app

COPY run_bootnode.sh /app/run_bootnode.sh

RUN chmod +x /app/run_bootnode.sh

RUN bootnode -genkey /app/bootnode.key || true

EXPOSE 30301/udp
EXPOSE 30301/tcp
EXPOSE 8080  # expose web log endpoint

ENTRYPOINT ["/app/run_bootnode.sh"]
