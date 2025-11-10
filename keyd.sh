#!/bin/bash

yay -S keyd

sudo systemctl enable keyd --now

sudo tee /etc/keyd/default.conf << 'EOF'
[ids]

*

[main]

# Maps capslock to escape when pressed and control when held.
capslock = overload(control, esc)

# Remaps the escape key to capslock
esc = capslock
EOF

sudo keyd reload
