#!/bin/bash

set -e -u

username="$1"
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Remove old installation
[ -d /home/"$username"/.vim ] && rm -rf /home/"$username"/.vim
[ -e /home/"$username"/.vimrc ] && rm -f /home/"$username"/.vimrc

# Install vim
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim

curl -fLo /home/"$username"/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set up scripts and configurations
cp "$cur_path"/.vimrc /home/"$username"/
sed -i "s/tobias/$username/" /home/"$username"/.vimrc
cp -r "$cur_path"/after /home/"$username"/.vim/
cp "$cur_path"/coc-settings.json /home/"$username"/.vim/

# Install vim plugins
set +e
vim -es -u /home/"$username"/.vimrc -i NONE -c "PlugInstall" -c "qa"
exit 0
