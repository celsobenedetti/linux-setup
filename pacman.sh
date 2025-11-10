#!/bin/bash

yay -S \
    hyprsunset \
    wget \
    stow \
    tmux \
    tmuxinator \
    zk \
    just \
    age \
    mkcert \
    act

# aur
yay -S \
    ngrok

mise settings add idiomatic_version_file_enable_tools node
