#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "Removing old installation..."
[ -e /home/"$username"/.fzf.bash ] && rm -f /home/"$username"/.fzf.bash
[ -d /home/"$username"/.fzf ] && rm -rf /home/"$username"/.fzf

git clone --depth 1 https://github.com/junegunn/fzf.git /home/"$username"/.fzf
/home/"$username"/.fzf/install --key-bindings --completion --no-update-rc
