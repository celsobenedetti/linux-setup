#!/bin/bash

yay -S \
  age \
  hyprsunset \
  just \
  mkcert \
  openpomodoro \
  stow \
  timer \
  tmux \
  tmuxinator \
  wget \
  zk \
  gum

# aur
yay -S \
  ngrok

# make mise respect nvmrc
mise settings add idiomatic_version_file_enable_tools node
