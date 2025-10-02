#!/usr/bin/env bash
set -euo pipefail

# adds ssh key to github account
#
# 1. if no ssh key exist, exit early
# 2. if GITHUB_TOKEN env variable is not present,  exit early
# 3. all good, POST ssh key to github API
# 4. add github.com to known_hosts

SSH_KEY="$HOME/.ssh/id_rsa.pub"

check_deps_or_exit() {
    for cmd in curl ssh-keyscan jq hostname whoami; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "$cmd not found, exiting."
            exit 1
        fi
    done

    if [ -z "$SSH_KEY" ] || [ ! -f "$SSH_KEY" ]; then
        echo "No SSH public key found, exiting."
        exit 1
    fi

    if [ -z "${GITHUB_TOKEN:-}" ]; then
        echo "GITHUB_TOKEN environment variable not set, exiting."
        exit 1
    fi
}

check_deps_or_exit

HOSTNAME="$(hostname)"
USERNAME="$(whoami)"
PUBKEY_CONTENT="$(<"$SSH_KEY")"
TITLE="${USERNAME}@${HOSTNAME}"
KNOWN_HOSTS="$HOME/.ssh/known_hosts"

PAYLOAD=$(jq -n --arg title "$TITLE" --arg key "$PUBKEY_CONTENT" '{title: $title, key: $key}')

TMP_RESP="$(mktemp)"
trap 'rm -f "$TMP_RESP"' EXIT

RESPONSE=$(
    curl -sS -w "%{http_code}" -o "$TMP_RESP" \
        -X POST https://api.github.com/user/keys \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        -d "$PAYLOAD"
)

if [ "$RESPONSE" -ne 201 ]; then
    echo "Failed to add key to GitHub, response:"
    cat "$TMP_RESP"
    exit 2
fi

echo "SSH key $SSH_KEY added to GitHub!"

if ! ssh-keygen -F github.com >/dev/null; then
    ssh-keyscan -H github.com >>"$KNOWN_HOSTS"
fi

echo "SSH key \"$SSH_KEY\" added to GitHub and github.com is in known_hosts."
