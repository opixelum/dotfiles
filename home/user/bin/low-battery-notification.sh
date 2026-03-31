#!/bin/bash

BATTERY_PATH=$(upower -e | grep battery)
BATTERY_PERCENTAGE=$(upower -i $BATTERY_PATH | awk '/percentage/ {print int($2)}')
CHARGING_STATUS=$(upower -i $BATTERY_PATH | grep state)

if [[ $BATTERY_PERCENTAGE -lt 20 ]] && [[ $CHARGING_STATUS == *"discharging"* ]]; then
    notify-send --urgency=critical "Low battery" "Plug in the power cable"
fi
