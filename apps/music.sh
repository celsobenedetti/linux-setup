#!/bin/bash

yay -S mpd mpc mpdris2 rmpc

mkdir -p ~/.mpd 2>/dev/null

sudo systemctl enable --user --now mpd
