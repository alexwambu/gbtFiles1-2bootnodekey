#!/bin/sh
set -e

BOOTNODE_KEY="bootnode.key"
STATIC_FILE="static-nodes.json"

# If no bootnode.key exists, generate one
if [ ! -f $BOOTNODE_KEY ]; then
  echo "[*] No $BOOTNODE_KEY found, generating..."
  bootnode -genkey $BOOTNODE_KEY
  echo "[*] Generated new $BOOTNODE_KEY"
fi

# Derive the public enode address
ENODE=$(bootnode -nodekey $BOOTNODE_KEY -writeaddress)

# Get public IP from Render environment
PUBLIC_IP=$(curl -s https://api.ipify.org || echo "127.0.0.1")

# Construct full enode URL
FULL_ENODE="enode://$ENODE@$PUBLIC_IP:30301"

echo "[*] Bootnode public enode: $FULL_ENODE"

# Write static-nodes.json for RPC nodes
echo "[\"$FULL_ENODE\"]" > $STATIC_FILE
echo "[*] Wrote $STATIC_FILE with bootnode enode"

# Start bootnode
exec bootnode -nodekey $BOOTNODE_KEY -addr :30301
