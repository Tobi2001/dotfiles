#!/bin/bash

# Script directory
cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
tmp_dir=$(mktemp -d) || { echo "Failed to create temp file"; exit 1; }

# Stdout colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

function promptOverride {
    local file="$(basename "$1")"
    if [ -e "$2"/"$file" ]; then
        while true; do
            read -p "$(echo -e "${YELLOW}$file already exists, override? ${NC}")" yn
            case $yn in
                "" )
                    ;&
                [Yy]*) 
                    cp -r "$1" "$2"
                    break;;
                [Nn]*) 
                    return
                    ;;
                *) 
                    echo "Please answer yes or no"
                    ;;
            esac
        done
    else
        cp -r "$1" "$2"
    fi
}

# Better GDB
promptOverride "$cur_dir"/.gdbinit ~
promptOverride "$cur_dir"/.gdbinit.d ~

# Tmux
promptOverride "$cur_dir"/.tmux.conf ~
promptOverride "$cur_dir"/.bash_profile ~
if [ ! -d ~/.tmux/plugins/tmux-yank ]; then
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tmux-yank.git "$_"/tmux-yank
fi

# Vim
promptOverride "$cur_dir"/.ycm_extra_conf.py ~
promptOverride "$cur_dir"/.vimrc ~

## pathogen
if ! command -v curl &> /dev/null; then
    sudo apt install curl
fi
if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

function installVimPackage {
    local pkg_name="$(basename "$1" .git)"
    if [ ! -d ~/.vim/bundle/"$pkg_name" ]; then
        git clone "$1" ~/.vim/bundle/"$pkg_name"
        return 0
    fi
    return 1
}

## colorscheme
if [ ! -d ~/.vim/colors ]; then
    git clone https://github.com/danilo-augusto/vim-afterglow.git "$tmp_dir"/afterglow
    cp -r "$tmp_dir"/afterglow/{autoload,colors} ~/.vim/
fi

## packages
installVimPackage https://github.com/vim-airline/vim-airline.git
installVimPackage https://github.com/preservim/nerdtree.git
installVimPackage https://github.com/tpope/vim-surround.git

if installVimPackage https://github.com/ycm-core/YouCompleteMe.git; then
    sudo apt install build-essential cmake python3-dev
    cd ~/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    python3 install.py --clangd-completer
    cd - &> /dev/null
fi

# Git
promptOverride "$cur_dir"/.gitconfig ~
promptOverride "$cur_dir"/.gitignore_global ~

# QtCreator
if [ ! -e ~/.config/QtProject/qtcreator/styles/custom_modnokai_night_shift.xml ]; then
    mkdir -p ~/.config/QtProject/qtcreator/styles
    cp  "$cur_dir"/qtcreator-style/custom_modnokai_night_shift.xml "$_"
fi

if [ ! -e ~/.config/QtProject/qtcreator/uncrustify/code_style.cfg ]; then
    mkdir -p ~/.config/QtProject/qtcreator/uncrustify
    cp  "$cur_dir"/uncrustify/code_style.cfg "$_"
fi

rm -rf "$tmp_dir"
echo -e "${GREEN}Setup completed${NC}"
exit 0
