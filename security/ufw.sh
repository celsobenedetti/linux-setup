#!/bin/bash

sudo pacman -S ufw

sudo systemctl enable ufw

# needed for traefik container to access local port
sudo ufw allow from 172.19.0.0/16 to any port 9080 proto tcp
sudo ufw allow from 172.19.0.1/16 to any port 3000 proto tcp # admin
sudo ufw allow from 172.19.0.1/16 to any port 3001 proto tcp # conversation
