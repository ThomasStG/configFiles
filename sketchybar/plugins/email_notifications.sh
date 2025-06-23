#!/usr/bin/env bash

count=$(curl -s --user 'thomassgallaher@gmail.com:bjyu jstu cgap bdje' \
  "https://mail.google.com/mail/feed/atom" \
  | sed -n 's:.*<fullcount>\(.*\)</fullcount>.*:\1:p')
count2=$(curl -s --user 'thomasgjunk1@gmail.com:cykd ocpn yvfv yulz' \
  "https://mail.google.com/mail/feed/atom" \
  | sed -n 's:.*<fullcount>\(.*\)</fullcount>.*:\1:p')

# Default to 0 if empty
count=${count:-0}
count2=${count2:-0}

# Sum counts
total=$((count + count2))

# Update SketchyBar
sketchybar --set gmail_unread label="$total" icon="󰊫"
