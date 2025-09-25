#!/bin/bash
set -e

# Generate key if it does not exist
if [ ! -f bootnode.key ]; then
  echo "[*] No bootnode.key found, generating one..."
  bootnode -genkey bootnode.key
fi

# Run bootnode
echo "[*] Starting bootnode..."
exec bootnode -nodekey bootnode.key -addr :30301
