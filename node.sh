#!/bin/bash

# 1 install fnm
# 2 install node version
# 3 install pnpm

# 1
cargo install fnm

export PATH=$PATH:$HOME/.cargo/bin

# 2
fnm install --lts

# 3. install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
