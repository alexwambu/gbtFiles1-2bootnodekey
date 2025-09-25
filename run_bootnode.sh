#!/bin/sh
set -e

# If bootnode.key is missing, generate it
if [ ! -f "/app/bootnode.key" ]; then
  echo "⚡ bootnode.key not found, generating..."
  bootnode -genkey /app/bootnode.key
fi

echo "✅ Starting GBTNetwork bootnode..."
exec bootnode -nodekey /app/bootnode.key -addr :30301
