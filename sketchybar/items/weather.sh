#!/bin/bash

weather=$(curl -s "wttr.in/?format=1")
sketchybar --set weather label="$weather"
