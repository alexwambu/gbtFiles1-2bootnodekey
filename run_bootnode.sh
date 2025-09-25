#!/bin/bash
set -e

# If no key exists, generate one
if [ ! -f bootnode.key ]; then
  echo "[*] Generating bootnode.key..."
  bootnode -genkey bootnode.key
fi

# Start bootnode
echo "[*] Bootnode running..."
exec bootnode -nodekey bootnode.key -addr :30301
