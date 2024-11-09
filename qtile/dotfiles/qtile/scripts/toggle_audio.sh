#!/bin/zsh

# Automatically get the default sink name or index
SINK_NAME=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Get the current active port for the detected sink
CURRENT_PORT=$(pactl list sinks | grep "Active Port" | awk '{print $3}')

# Define the ports to toggle between
PORT_HEADPHONES="analog-output-headphones"
PORT_LINEOUT="analog-output-lineout"

# Toggle the port
if [[ "$CURRENT_PORT" == "$PORT_HEADPHONES" ]]; then
    pactl set-sink-port "$SINK_NAME" "$PORT_LINEOUT"
else
    pactl set-sink-port "$SINK_NAME" "$PORT_HEADPHONES"
fi

