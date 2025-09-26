#!/bin/sh
set -e

KEY_FILE="/app/bootnode.key"

# Generate bootnode key if not found
if [ ! -f "$KEY_FILE" ]; then
  echo "⚡ bootnode.key not found, generating..."
  bootnode -genkey "$KEY_FILE"
fi

# Extract and log enode address
echo "🔑 Your GBTNetwork Bootnode Enode Address:"
ENODE=$(bootnode -nodekey "$KEY_FILE" -writeaddress)
echo "enode://$ENODE@0.0.0.0:30301"

# Start bootnode service
echo "✅ Starting GBTNetwork Bootnode on :30301..."
exec bootnode -nodekey "$KEY_FILE" -addr :30301
