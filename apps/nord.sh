#!/bin/bash

sudo pacman -S nordvpn-bin

sudo groupadd nordvpn
sudo usermod -aG nordvpn "$USER"

sudo systemctl enable --now nordvpnd
