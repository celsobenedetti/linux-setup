#!/usr/bin/env bash

# https://www.freecodecamp.org/news/how-to-get-https-working-on-your-local-development-environment-in-5-minutes-7af615770eec/

set -euo pipefail

# 0. Ensure mkcert is installed (and nss trust tools for Firefox, if needed)
if ! command -v mkcert >/dev/null 2>&1; then
    echo "Install mkcert first:"
    echo "  yay -S mkcert     # or use your AUR helper"
    echo "Or install via https://github.com/FiloSottile/mkcert"
    exit 1
fi
if ! command -v certutil >/dev/null 2>&1; then
    echo "Install nss tools for Firefox trust integration: sudo pacman -S nss"
fi

# 1. Install the local CA (first run only)
CA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/mkcert"
if [[ -f "$CA_DIR/rootCA-key.pem" && -f "$CA_DIR/rootCA.pem" ]]; then
    echo "mkcert root CA already installed, skipping mkcert -install."
else
    mkcert -install
fi

echo "----------"
echo "DONE."
echo "You will get two files: 'localhost.pem' (cert) and 'localhost-key.pem' (private key)."
echo "Use these in your server config for HTTPS."
