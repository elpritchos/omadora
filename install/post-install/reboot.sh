#!/bin/bash

clear
tte -i ~/.local/share/omadora/logo.txt --frame-rate 920 laseretch
echo
echo "You're done! So we're ready to reboot now..." | tte --frame-rate 640 wipe

sleep 5
reboot
