#!/bin/bash

yay -S tailscale

sudo systemctl enable --now tailscaled
