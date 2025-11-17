#!/bin/bash

yay -S \
    wget \
    stow \
    tmux \
    mkcert \
    age \
    zk \
    timer \
    openpomodoro \
    just \
    tmuxinator \
    hyprsunset

# aur
yay -S \
    ngrok

# make mise respect nvmrc
mise settings add idiomatic_version_file_enable_tools node
