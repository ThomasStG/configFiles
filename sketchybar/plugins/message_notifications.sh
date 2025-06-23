#!/usr/bin/env bash

count=$(sqlite3 -readonly ~/Library/Messages/chat.db \
  "SELECT COUNT(*) FROM message WHERE is_read = 0 AND is_from_me = 0 AND text IS NOT NULL;")

if [[ "$count" =~ ^[0-9]+$ && "$count" -gt 0 ]]; then
  sketchybar --set message_unread label="$count" icon="󰭹" icon.color=0xffcc3300
else
  sketchybar --set message_unread label="0" icon="󰭹" icon.color=0xffffffff
fi
