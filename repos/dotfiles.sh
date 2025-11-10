#!/bin/bash

if [[ -d ~/.dotfiles ]]; then
    echo "dotfiles already exists, aborting."
    exit 0
fi

gh repo clone celsobenedetti/dotfiles ~/.dotfiles

cd ~/.dotfiles || exit

make
