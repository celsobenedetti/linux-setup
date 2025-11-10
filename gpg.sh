#!/usr/bin/env bash
set -euo pipefail

# Exit immediately if NAME or EMAIL are not set
: "${NAME:?Error: NAME environment variable is required}"
: "${EMAIL:?Error: EMAIL environment variable is required}"

# Optional: customize key type and expiration
KEY_ALGO="1"             # 1 = RSA (sign/cert); use 17 for DSA, 18/22 for EdDSA
KEY_LENGTH="4096"        # Bits for primary key (ignored for ECC/EdDSA)
SUBKEY_ALGO="1"          # 1 = RSA (encrypt); use 16 for ELG-E
SUBKEY_LENGTH="4096"     # Bits for subkey
EXPIRE="0"               # 0 = never; "2y" = 2 years

# ===========================================================================
# === 1. Generate Key ===========================================
# ===========================================================================

echo "Generating GPG key..."
echo "   Name:  $NAME"
echo "   Email: $EMAIL"
echo "   Type:  RSA $KEY_LENGTH (primary), $SUBKEY_LENGTH (subkey)"
echo "   Expire: $EXPIRE"
echo

# Generate key in batch mode
BATCH=$(mktemp)
trap 'rm -f "$BATCH"' EXIT

cat > "$BATCH" <<EOF
Key-Type: $KEY_ALGO
Key-Length: $KEY_LENGTH
Subkey-Type: $SUBKEY_ALGO
Subkey-Length: $SUBKEY_LENGTH
Name-Real: $NAME
Name-Email: $EMAIL
Expire-Date: $EXPIRE
%commit
EOF

gpg --batch --gen-key "$BATCH"


# ===========================================================================
# === 2. add key to git ===========================================
# ===========================================================================

KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep 'sec' | awk '{print $2}' | cut -d'/' -f2 | head -n1)

if [ -z "$KEY_ID" ]; then
    echo "Failed to create GPG key"
    exit 1
fi

git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo "Your new GPG key ID: $KEY_ID"
echo "Setup complete. Git is configured to sign commits with this key."

