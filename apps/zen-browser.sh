#!/bin/bash
#
# 1. Remove any existing zen-browser installation, config, and cache
# 2. wget latest zen-browser release
# 3. extract to $INSTALL_DIR
# 4. create symlink to $BIN_INSTALL_PATH

INSTALL_DIR="/home/$USER/local/zen-browser"
BIN_INSTALL_PATH="$INSTALL_DIR/zen/zen"

BIN_DIR="/home/$USER/.local/bin"
BIN_TARGET_PATH="$BIN_DIR/zen"

DOWNLOAD_URL="https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz"
DOWNLOAD_TAR_TARGET="$INSTALL_DIR/zen.linux-x86_64.tar.xz"

CONFIG_DIR1="/home/$USER/.config/zen-browser"
CONFIG_DIR2="/home/$USER/.config/Zen"
CACHE_DIR1="/home/$USER/.cache/zen-browser"
CACHE_DIR2="/home/$USER/.cache/Zen"

link_bin() {
    mkdir "$BIN_DIR" 2>/dev/null
    ln -sf "$BIN_INSTALL_PATH" "$BIN_TARGET_PATH"
}

remove_existing() {
    echo "Removing previous Zen Browser installation, configs, and cache..."
    rm -rf "$INSTALL_DIR"
    rm -f "$BIN_TARGET_PATH"
    rm -rf "$CONFIG_DIR1" "$CONFIG_DIR2"
    rm -rf "$CACHE_DIR1" "$CACHE_DIR2"
}

remove_existing

mkdir -p "$INSTALL_DIR" >/dev/null 2>&1

wget $DOWNLOAD_URL -O "$DOWNLOAD_TAR_TARGET"

if [[ -f "$DOWNLOAD_TAR_TARGET" ]]; then
    tar -xf "$DOWNLOAD_TAR_TARGET" -C "$INSTALL_DIR"
    rm "$DOWNLOAD_TAR_TARGET"
fi

link_bin

echo "Zen Browser reinstalled successfully."
