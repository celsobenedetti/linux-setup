#!/bin/bash

yay -S tailscale

sydo systemctl enable --now tailscaled
