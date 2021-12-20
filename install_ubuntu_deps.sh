#/bin/bash

set -e -u

username="$1"
os_version="$2"

if [ "$os_version" = "20.04" ]; then
    clang_version="11"
    node_version="16"
elif [ "$os_version" = "18.04" ]; then
    clang_version="10"
    node_version="14"
else
    echo "Ubuntu version $os_version is not supported" &>2
    exit 1
fi

curl -sL https://deb.nodesource.com/setup_"$node_version".x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt-get install -y --no-install-recommends nodejs
[ -e /tmp/nodesource_setup.sh ] && rm /tmp/nodesource_setup.sh

sudo apt-get install -y --no-install-recommends clangd-"$clang_version" python3-pip cmake tmux xclip git gdb
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-"$clang_version" 100

sudo -u "$username" python3 -m pip install --user -U autopep8
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

sudo npm i -g npm
sudo npm i -g bash-language-server

