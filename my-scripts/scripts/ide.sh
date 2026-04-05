#!/bin/bash
tmux new-session -d -s work
tmux rename-window -t work:1 'Dev'
tmux split-window -v -t work:1
tmux split-window -h -t work:1
tmux select-pane -t 1
tmux send-keys 'htop' C-m
tmux attach-session -t work

