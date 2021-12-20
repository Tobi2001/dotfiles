#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Remove old installation
[ -e /home/"$username"/.config/uncrustify ] && rm -rf /home/"$username"/.config/uncrustify

# Build uncrustify from source
mkdir -p /home/"$username"/.config/uncrustify/uncrustify_package
cp "$cur_path"/code_style.cfg /home/"$username"/.config/uncrustify/
cd /home/"$username"/.config/uncrustify/uncrustify_package
git clone https://github.com/uncrustify/uncrustify.git .
git checkout 45b836cff
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make
