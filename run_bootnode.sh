#!/bin/sh
set -e

cd /app

# If key missing, generate it
if [ ! -f "bootnode.key" ]; then
  echo "⚡ Generating bootnode.key..."
  bootnode -genkey bootnode.key
fi

# Export enode to a file
ENODE=$(bootnode -nodekey bootnode.key -writeaddress)
echo "enode://$ENODE@0.0.0.0:30301" > /app/enode.txt
echo "✅ Bootnode enode saved to /app/enode.txt"
cat /app/enode.txt

# Start a tiny web server to serve enode.txt
( while true; do nc -l -p 8080 -q 1 < /app/enode.txt; done ) &

# Start bootnode
echo "🚀 Starting bootnode..."
exec bootnode -nodekey bootnode.key -addr :30301
