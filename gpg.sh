#!/bin/bash

gpg --full-gen-key

KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" | grep 'sec' | awk '{print $2}' | cut -d'/' -f2 | head -n1)

if [ -z "$KEY_ID" ]; then
    echo "Failed to create GPG key"
    exit 1
fi

git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo "Your new GPG key ID: $KEY_ID"
echo "Setup complete. Git is configured to sign commits with this key."
