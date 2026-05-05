#!/bin/bash

: "${NOTES:?Error: NOTES environment variable is required}"
REPO="celsobenedetti/zk"

if [[ -d $NOTES ]]; then
    echo "$NOTES already exists, aborting."
    exit 0
fi

gh repo clone "$REPO" "$NOTES"
