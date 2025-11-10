#!/bin/bash

DIR="/mnt/1tb/work"

mkdir -p "$DIR"

cd "$DIR" || exit
echo "Cloning repos in  $DIR"

gh repo clone plaidbean/integrations-private
gh repo clone plaidbean/chatbot
gh repo clone graduway/diploma-platform
