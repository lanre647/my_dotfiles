#!/bin/bash
# Start the Polkit agent for those EOS apps
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Apache NetBeans + Java apps often break on dwm because Java expects a reparenting window manager
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG4D &

# so every dwm sess would see my /home/usr/.local/bin dir :)-|-|
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# key repeat
 xset r rate 200 50 &
# Start the compositor
picom --config ~/.config/picom/picom.conf &

# bar, popup notifications, clipboard manager, auto mounting disk 
slstatus &
dunst &
clipmenud &
udiskie &

# Start the wallpaper
feh --bg-fill /home/lanre/Pictures/wallpapers/"27. Catppuccin Mocha.png"
# Set the wallpaper 
#while true; do
#feh --bg-fill "$(find ~/Pictures/wallpapers -type f | shuf -n 1)"
#    sleep 1m
#done &

# Start the window manager (Must be last and No '&')
exec dwm
