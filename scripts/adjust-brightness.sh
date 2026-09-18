#!/bin/bash

# Get current brightness
val=$(xrandr --verbose | grep -i brightness | cut -f2 -d ' ')

# Calculate new value
if [ "$1" == "up" ]; then
    new_val=$(echo "$val + 0.1" | bc)
    # Check if > 1.0
    if [ "$(echo "$new_val > 1.0" | bc)" -eq 1 ]; then
        new_val=1.0
    fi
elif [ "$1" == "down" ]; then
    new_val=$(echo "$val - 0.1" | bc)
    # Check if < 0.1
    if [ "$(echo "$new_val < 0.1" | bc)" -eq 1 ]; then
        new_val=0.1
    fi
else
    exit 1
fi

xrandr --output eDP-1 --brightness "$new_val"
