#!/bin/bash

active_port=$(pactl list sinks | grep "Active Port" | awk '{print $3}')
if [ "$active_port" == "analog-output-headphones" ]; then
    echo "󰋋"  # Headphone icon
else
    echo "󰓃"  # Speaker icon
fi
