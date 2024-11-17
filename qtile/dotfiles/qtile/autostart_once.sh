#!/bin/bash

# # Apply wallpaper using wal
# wal -i ~/Wallpaper/claudio-testa-FrlCwXwbwkk-unsplash.jpg &&

# Start picom
picom --config ~/.config/picom/picom.conf &

xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97

# Start Copyq
copyq &

# kitty
