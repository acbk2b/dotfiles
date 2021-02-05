#!/bin/bash

~/.screenlayout/main-layout.sh

# ~/scripts/wallpaper.sh
variety &

picom &

ID=$(xinput | grep "Synaptics" | cut -f2 | cut -d "=" -f2)
xinput set-prop $ID 321 1

numlockx &

# Redshift geolocation using geoclue2
# Enable geoclue agent
/usr/lib/geoclue-2.0/demos/agent &
