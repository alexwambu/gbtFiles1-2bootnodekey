#!/bin/sh
set -e

BOOTNODE_URL=${BOOTNODE_URL:-"https://gbtnetwork-bootnode.onrender.com/static-nodes.json"}
DATADIR=${DATADIR:-"/root/.gbtnetwork"}
REFRESH_INTERVAL=${REFRESH_INTERVAL:-300}   # seconds

mkdir -p "$DATADIR"

fetch_static_nodes() {
  echo "🌍 Fetching static-nodes.json from $BOOTNODE_URL..."
  curl -s -o "$DATADIR/static-nodes.json" "$BOOTNODE_URL" || true

  if [ ! -s "$DATADIR/static-nodes.json" ]; then
    echo "⚠️ static-nodes.json not fetched"
  else
    echo "✅ static-nodes.json updated at $(date)"
  fi
}

# First fetch
fetch_static_nodes

# Background refresh
(
  while true; do
    sleep "$REFRESH_INTERVAL"
    fetch_static_nodes
  done
) &

# Start node
echo "🚀 Starting GBTNetwork node..."
exec geth \
  --datadir "$DATADIR" \
  --networkid 999 \
  --http --http.addr 0.0.0.0 --http.port 9636 --http.api "eth,net,web3,txpool" \
  --port 30303 \
  --ipcdisable \
  --syncmode "full"
