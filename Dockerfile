# GBTNetwork Node based on Go-Ethereum
FROM ethereum/client-go:alltools-stable

WORKDIR /app

# Install curl + bash for cron-like loop
RUN apk add --no-cache curl bash

COPY run_node.sh /app/run_node.sh
RUN chmod +x /app/run_node.sh

EXPOSE 9636     # RPC
EXPOSE 30303/udp
EXPOSE 30303/tcp

ENTRYPOINT ["/app/run_node.sh"]
