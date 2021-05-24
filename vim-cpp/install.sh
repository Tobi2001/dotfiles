#/bin/bash

while getopts ":u:" opt; do
    case ${opt} in
        u )
            username=$OPTARG
            ;;
        \? ) 
            echo "Usage: $0 [-u <username>]"
            exit 1
            ;;
    esac
done
username="${username:-tobias}"
if [ ! -d "/home/${username}/" ]; then
    echo "Failed to find home directory for user $username" >&2
    exit 1
fi

# Remove existing installation
if [ -d "/home/${username}/.vim" ]; then
    read -p "An existing config was found, do you want to do a clean install? [y|N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "Removing existing configurations..."
        rm -rf /home/"$username"/.vim
        [ -e /home/"$username"/.vimrc ] && rm -f /home/"$username"/.vimrc
        [ -e /home/"$username"/.tmux.conf ] && rm -f /home/"$username"/.tmux.conf
        [ -e /home/"$username"/.tmux ] && rm -rf /home/"$username"/.tmux
        [ -e /home/"$username"/.config/uncrustify ] && rm -rf /home/"$username"/.config/uncrustify
    else
        echo "Aborting..."
        exit 1
    fi
fi

# Install dependencies
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
ubuntu_version="$(lsb_release -rs)"
if [ "$ubuntu_version" = "20.04" ]; then
    source "$cur_path"/install_ubuntu20_deps.sh
elif [ "$ubuntu_version" = "18.04" ]; then
    source "$cur_path"/install_ubuntu18_deps.sh
else
    echo "Ubuntu version $ubuntu_version is not supported" &>2
    exit 1
fi

# Set up scripts and configurations
cp "$cur_path"/.vimrc /home/"$username"/
sed -i "s/tobias/$username/" /home/"$username"/.vimrc
cp -r "$cur_path"/after /home/"$username"/.vim/
cp "$cur_path"/coc-settings.json /home/"$username"/.vim/
cp "$cur_path"/../.tmux.conf /home/"$username"/
cp -r "$cur_path"/../uncrustify/ /home/"$username"/.config/

# Fetch tmux-yank plugin
mkdir -p /home/"$username"/.tmux/plugins/
git clone https://github.com/tmux-plugins/tmux-yank /home/"$username"/.tmux/plugins/

# Build and install uncrustify
cd /home/"$username"/.config/uncrustify/
git clone https://github.com/uncrustify/uncrustify.git
cd uncrustify
git checkout 45b836cff
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

# Install vim plugins
vim -es -u /home/"$username"/.vimrc -i NONE -c "PlugInstall" -c "qa"

