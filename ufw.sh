#!/bin/bash

sudo pacman -S ufw

sudo systemctl enable ufw

# needed for traefik container to be able to access local 9080 port
sudo ufw allow from 172.19.0.0/16 to any port 9080 proto tcp
