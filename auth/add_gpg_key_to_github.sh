#!/usr/bin/env bash
set -euo pipefail
# adds GPG key to GitHub account
#
# 1. if no GPG secret key exists, exit early
# 2. if GITHUB_TOKEN env variable is not present, exit early
# 3. If github already in known_hosts, exit early
#
# 4. otherwise, POST GPG key to GitHub API

HOSTNAME="$(hostname)"
USERNAME="$(whoami)"
KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep '^sec' | awk '{print $2}' | cut -d'/' -f2 | head -n1)
ARMORED_PUBLIC_KEY=$(gpg --armor --export "$KEY_ID")
TITLE="${USERNAME}@${HOSTNAME} (GPG)"

check_deps_or_exit() {
    for cmd in curl gpg jq hostname whoami; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "$cmd not found, exiting."
            exit 1
        fi
    done

    if ! KEY_ID=$(gpg --list-secret-keys --keyid-format=long 2>/dev/null | grep '^sec' | awk '{print $2}' | cut -d'/' -f2 | head -n1); then
        echo "No GPG secret key found, exiting."
        exit 1
    fi
    if [ -z "$KEY_ID" ]; then
        echo "No GPG secret key found, exiting."
        exit 1
    fi

    # Export public key to verify
    if ! gpg --armor --export "$KEY_ID" >/dev/null 2>&1; then
        echo "Failed to export GPG public key for ID: $KEY_ID, exiting."
        exit 1
    fi

    if [ -z "${GITHUB_TOKEN:-}" ]; then
        echo "GITHUB_TOKEN environment variable not set, exiting."
        exit 1
    fi
}

check_deps_or_exit

PAYLOAD=$(jq -n \
    --arg name "$TITLE" \
    --arg armored_public_key "$ARMORED_PUBLIC_KEY" \
    '{name: $name, armored_public_key: $armored_public_key}')

TMP_RESP="$(mktemp)"
trap 'rm -f "$TMP_RESP"' EXIT

RESPONSE=$(
    curl -sS -w "%{http_code}" -o "$TMP_RESP" \
        -X POST https://api.github.com/user/gpg_keys \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        -d "$PAYLOAD"
)

if [ "$RESPONSE" -ne 201 ]; then
    echo "Failed to add GPG key to GitHub (HTTP $RESPONSE), response:"
    cat "$TMP_RESP"
    exit 2
fi

echo "GPG key (ID: $KEY_ID) added to GitHub!"
echo "GPG key \"$KEY_ID\" added to GitHub account."
