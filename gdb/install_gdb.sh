#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "Removing old installation..."
[ -e /home/"$username"/.gdbinit ] && rm -f /home/"$username"/.gdbinit
[ -d /home/"$username"/.gdbinit.d ] && rm -rf /home/"$username"/.gdbinit.d

echo "Copying config files..."
cp "$cur_path"/.gdbinit /home/"$username"/
cp -r "$cur_path"/.gdbinit.d /home/"$username"/
