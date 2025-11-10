#!/bin/bash

# Install ClamAV
sudo pacman -S clamav

# install base definitions
sudo freshclam

sudo systemctl enable clamav-daemon
