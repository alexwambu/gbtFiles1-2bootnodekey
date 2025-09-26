#!/bin/bash
set -e

BOOTNODE_URL=${BOOTNODE_URL:-"https://gbtnetwork-bootnode.onrender.com/static-nodes.json"}
DATADIR=${DATADIR:-"/root/.gbtnetwork"}
REFRESH_INTERVAL=${REFRESH_INTERVAL:-300}   # 300s = 5min

mkdir -p "$DATADIR"

fetch_static_nodes() {
  echo "🌍 Fetching static-nodes.json from $BOOTNODE_URL..."
  curl -s -o "$DATADIR/static-nodes.json" "$BOOTNODE_URL"

  if [ ! -s "$DATADIR/static-nodes.json" ]; then
    echo "❌ Failed to fetch static-nodes.json"
  else
    echo "✅ static-nodes.json refreshed at $(date):"
    cat "$DATADIR/static-nodes.json"
  fi
}

# Initial fetch before starting node
fetch_static_nodes

# Start background refresher loop
(
  while true; do
    sleep "$REFRESH_INTERVAL"
    fetch_static_nodes
  done
) &

# Start geth node
echo "🚀 Starting GBTNetwork node with RPC :9636"
exec geth \
  --datadir "$DATADIR" \
  --networkid 999 \
  --http --http.addr 0.0.0.0 --http.port 9636 --http.api "eth,net,web3,txpool" \
  --port 30303 \
  --ipcdisable \
  --syncmode "full"
