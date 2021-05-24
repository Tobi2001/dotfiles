#/bin/bash

curl -sL https://deb.nodesource.com/setup_14.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt-get install -y nodejs
[ -e /tmp/nodesource_setup.sh ] && rm /tmp/nodesource_setup.sh

sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim clangd-10 python3-pip cmake
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100

curl -fLo /home/"$username"/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo -u "$username" python3 -m pip install --user -U autopep8
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

sudo npm i -g bash-language-server
