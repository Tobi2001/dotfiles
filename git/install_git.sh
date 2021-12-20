#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "Removing old installation..."
[ -e /home/"$username"/.gitconfig ] && rm -f /home/"$username"/.gitconfig
[ -e /home/"$username"/.gitignore_global ] && rm -rf /home/"$username"/.gitignore_global

echo "Copying config files..."
cp "$cur_path"/gitconfig /home/"$username"/.gitconfig
sed -i "s/tobias/$username/" /home/"$username"/.gitconfig
cp "$cur_path"/gitignore_global /home/"$username"/.gitignore_global


