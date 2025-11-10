#!/bin/bash

yay -S syncthing

systemctl --user enable --now syncthing.service
