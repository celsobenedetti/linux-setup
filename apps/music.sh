#!/bin/bash

yay -S mpd mpc mpdris2 rmpc

mkdir -p ~/.mpd

sudo systemctl enable --now mpd
