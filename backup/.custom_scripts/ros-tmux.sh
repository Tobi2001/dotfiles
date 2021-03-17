#!/bin/bash

tmux new-session -d -s ros2
tmux rename-window 'build'
tmux send-keys 'roscd' 'C-m'
tmux send-keys 'clear' 'C-m'

tmux new-window -n 'run'
tmux send-keys 'roscd' 'C-m'
tmux send-keys 'clear' 'C-m'
tmux split-window -h
tmux send-keys 'roscd' 'C-m'
tmux send-keys 'glances -1 --hide-kernel-threads --fs-free-space --process-short-name' 'C-m'
tmux split-window -v
tmux send-keys 'roscd' 'C-m'
tmux send-keys 'clear' 'C-m'
tmux select-pane -t 0
tmux split-window -v
tmux send-keys 'roscd' 'C-m'
tmux send-keys 'clear' 'C-m'
tmux select-pane -t 0

tmux new-window -n 'files'
tmux send-keys 'roscd' 'C-m'
tmux send-keys 'clear' 'C-m'
tmux select-window -t 0
tmux attach-session -t ros2
