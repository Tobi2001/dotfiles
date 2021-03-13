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

curl -sL https://deb.nodesource.com/setup_10.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt-get install -y nodejs

sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim clangd-10
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cp "$cur_path"/.vimrc ~/
sed -i "s/tobias/$username/" ~/.vimrc
cp -r "$cur_path"/after ~/.vim/
cp "$cur_path"/coc-settings.json ~/.vim/
cp "$cur_path"/../.tmux.conf ~/
cp -r "$cur_path"/../uncrustify/ ~/.config/
