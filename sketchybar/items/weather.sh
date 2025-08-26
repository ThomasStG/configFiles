#!/bin/bash

weather=$(curl -s "wttr.in/?format=1" | awk '{$1=$1; print}')
sketchybar --set weather label="$weather"
