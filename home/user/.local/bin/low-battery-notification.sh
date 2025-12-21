#!/bin/bash

BATTERY_PATH=$(upower -e | grep battery)
BATTERY_PERCENTAGE=$(upower -i $BATTERY_PATH | awk '/percentage/ {print int($2)}')

if [[ $BATTERY_PERCENTAGE -lt 20 ]]; then
    notify-send --urgency=critical "Low battery" "Plug in the power cable"
fi
