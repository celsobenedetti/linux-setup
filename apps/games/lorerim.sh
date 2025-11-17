#!/bin/bash

# 1. install wabbajack and Lorerim
# 2. Add "Lorerim" Mog organizer to steam
#
#
# Wabbajack on linux
# https://github.com/Omni-guides/Jackify/wiki/Wabbajack-via-Proton
# https://github.com/Omni-guides/Jackify/wiki/Using-the-omni%E2%80%90guides.sh-Automation-Script
# https://github.com/Omni-guides/Jackify/wiki/General-Linux-Guide-(Anvil)

yay -S protontricks

APPID=$(protontricks -l | grep -i "Lorerim" | awk {'print $NF'} | sed 's:^.\(.*\).$:\1:')
protontricks --no-bwrap "$APPID" -q xact xact_x64 d3dcompiler_47 d3dx11_43 d3dcompiler_43 vcrun2022 dotnet6 dotnet7
