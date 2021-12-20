#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "Removing old installation..."
[ -d /home/"$username"/.bashrc ] && rm -rf /home/"$username"/.bashrc

echo "Copying config files..."
cp "$cur_path"/bashrc /home/"$username"/.bashrc
