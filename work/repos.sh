#!/bin/bash

: "${WORK:?Error: WORK environment variable is required}"

mkdir -p "$WORK"

cd "$WORK" || exit
echo "Cloning repos in  $WORK"

gh repo clone plaidbean/integrations-private
gh repo clone plaidbean/chatbot
gh repo clone graduway/diploma-platform
