#!/bin/bash
DIR="$HOME/Pictures/wallpapers"
selected=$(
find "$DIR" -type f | fzf \
  --preview='chafa --size=$(( $FZF_PREVIEW_COLUMNS ))x$(( $FZF_PREVIEW_LINES )) -- {}' \
  --preview-window=right:60%
)
clear
TRANSITIONS=(wipe wave grow fade outer)
TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
[ -n "$selected" ] && awww img "$selected" --transition-type "$TRANSITION"
