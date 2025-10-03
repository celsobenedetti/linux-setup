#!/bin/bash

# 1. remove existing go installation
# 2. get latest go version
# 3. download and extrct go

# 1 remove existing go installation
rm -rf /usr/local/go

# # 2 get latest go version
VERSION=$(curl -s https://go.dev/VERSION\?m=text | awk 'NR==1')
FILE="$VERSION.linux-amd64.tar.gz"

# # 3 download and extract go
wget "https://dl.google.com/go/$FILE"
sudo tar -C /usr/local -xzf "$FILE"
rm ./go*.tar.gz

# verify:
# export PATH=$PATH:/usr/local/go/bin
# go version
