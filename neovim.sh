#!/bin/bash
# 1. if existing neovim config exists, prompt user for cleanup
# 2. if yes, remove existing config
# 3. stow dotfiles into nvim config

NVIM_CONFIG="$HOME/.config/nvim"

if [[ -f "$NVIM_CONFIG/init.lua" ]]; then
    read -rp "Neovim config already exists, shall we remove it? (y/n) " answer
    case "$answer" in
    [Yy]*)
        echo "bro"
        sudo rm -r ~/.config/nvim 2>/dev/null
        echo "Removed ~/.config/nvim"
        sudo rm -r ~/.local/share/nvim 2>/dev/null
        echo "Removed ~/.local/share/nvim"
        rm -r ~/.local/state/nvim 2>/dev/null
        echo "Removed ~/.local/state/nvim"
        rm -r ~/.cache/nvim 2>/dev/null
        echo "Removed ~/.cache/nvim"
        ;;
    [Nn]*)
        echo "Aborting."
        exit 0
        ;;
    *)
        echo "Please answer y or n."
        exit 1
        ;;
    esac
fi

gh repo clone celsobenedetti/nvim ~/.config/nvim
