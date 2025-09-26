FROM ethereum/client-go:stable

WORKDIR /app

# Install curl for fetching static-nodes.json
RUN apk add --no-cache curl

COPY run_node.sh /app/run_node.sh
RUN chmod +x /app/run_node.sh

EXPOSE 9636 30303 30303/udp

ENTRYPOINT ["/app/run_node.sh"]
