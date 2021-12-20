#/bin/bash

set -e

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

echo "###########################"
echo "# Installing dependencies #"
echo "###########################"
sudo apt update
sudo apt install -y --no-install-recommends lsb-release curl
cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
"$cur_path"/install_ubuntu_deps.sh "$username" "$(lsb_release -rs)"

echo "###################"
echo "# Installing tmux #"
echo "###################"
"$cur_path"/tmux/install_tmux.sh "$username"

echo "#########################"
echo "# Installing uncrustify #"
echo "#########################"
"$cur_path"/uncrustify/install_uncrustify.sh "$username"

echo "##################"
echo "# Installing vim #"
echo "##################"
"$cur_path"/vim/install_vim.sh "$username"

echo "##################"
echo "# Installing git #"
echo "##################"
"$cur_path"/git/install_git.sh "$username"

echo "##################"
echo "# Installing gdb #"
echo "##################"
"$cur_path"/gdb/install_gdb.sh "$username"
