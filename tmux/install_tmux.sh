#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Remove old installation
[ -e /home/"$username"/.tmux.conf ] && rm -f /home/"$username"/.tmux.conf
[ -e /home/"$username"/.tmux ] && rm -rf /home/"$username"/.tmux

# Install config
cp "$cur_path"/.tmux.conf /home/"$username"/

# Fetch tmux-yank plugin
mkdir -p /home/"$username"/.tmux/plugins/
git clone https://github.com/tmux-plugins/tmux-yank /home/"$username"/.tmux/plugins/
