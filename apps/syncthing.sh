#!/bin/bash

yay -S syncthing 

systemctl --user enable syncthing.service
systemctl --user start syncthing.service
