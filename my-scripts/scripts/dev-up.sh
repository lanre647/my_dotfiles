#!/bin/bash
# Name your session
SESSION="work"
tmux new-session -d -s $SESSION
# Pane 1: Your Editor (e.g., Micro or Nvim)
tmux send-keys -t $SESSION "micro index.js" C-m
# Pane 2: Your Local Server
tmux split-window -h -t $SESSION
tmux send-keys -t $SESSION "node --watch index.js" C-m
# Attach to the session
tmux attach-session -t $SESSION

