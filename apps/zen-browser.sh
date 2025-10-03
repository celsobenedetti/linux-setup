#!/bin/bash
#
# 1. wget latest zen-browser release
# 2. extract to $INSTALL_DIR
# 3. create symlink to $BIN_INSTALL_PATH

INSTALL_DIR="/home/$USER/local/zen-browser"
BIN_INSTALL_PATH="$INSTALL_DIR/zen/zen"
BIN_TARGET_PATH="/home/$USER/.local/bin/zen"

DOWNLOAD_URL="https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz"
DOWNLOAD_TAR_TARGET="$INSTALL_DIR/zen.linux-x86_64.tar.xz"

link_bin() {
    ln -s "$BIN_INSTALL_PATH" "$BIN_TARGET_PATH"
}

if [[ -f "$BIN_INSTALL_PATH" ]]; then
    echo "zen-browser already installed"
    link_bin
    exit 0
fi

mkdir -p "$INSTALL_DIR" >/dev/null 2>&1

wget $DOWNLOAD_URL -O "$DOWNLOAD_TAR_TARGET"

if [[ -f "$DOWNLOAD_TAR_TARGET" ]]; then
    tar -xf "$DOWNLOAD_TAR_TARGET" -C "$INSTALL_DIR"
    rm "$DOWNLOAD_TAR_TARGET"
fi

link_bin
