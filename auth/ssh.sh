#!/bin/bash

set -euo pipefail

KEY_PATH="$HOME/.ssh/id_rsa"

if [[ -f "$KEY_PATH" ]] && [[ -f "$KEY_PATH.pub" ]]; then
    echo "SSH key already exists at $KEY_PATH"
    exit 0
fi

umask 077

read -rs -p "Enter passphrase for new SSH key (leave empty for none): " PASSPHRASE
echo

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -N "$PASSPHRASE" -q

echo "New SSH key created at $KEY_PATH"
echo "Your public key is:"
cat "$KEY_PATH.pub"

# add ssh key to agent
eval $(ssh-agent)
ssh-add
