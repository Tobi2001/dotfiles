
### Custom section ###

# General behavior
set -o vi

#Bash color
# PS1='\[\033[1;31m\]\u\[\033[1;31m\]@\[\033[1;31m\]\h:\[\033[1;33m\]\w\[\033[1;33m\]\$\[\033[0m\] '
PS1='\[\033[1;91m\]\u\[\033[1;91m\]@\[\033[1;91m\]\h:\[\033[1;93m\]\w\[\033[1;93m\]\$\[\033[0m\] '

# Aliases
alias vim="vim --servername VIM"

# Exports
export VISUAL=vim
export EDITOR="$VISUAL"

# GDB
gdb-tmux-helper()
{
    clear;
    local id="$(tmux split-window -hPF "#D" "tail -f /dev/null")"
    tmux last-pane
    local tty="$(tmux display-message -p -t "$id" '#{pane_tty}')"
    gdb -ex "dashboard -output $tty" "$@"
    tmux kill-pane -t "$id"
}

tgdb() {
    if tmux ls ; then
        if [ -z "$TMUX" ]; then
            tmux new-window -n 'gdb'
            tmux send-keys "gdb-tmux-helper $@" C-m
            tmux attach
        else
            gdb-tmux-helper "$@"
        fi
    else
        tmux new-session -d
        tmux send-keys "gdb-tmux-helper $@" C-m
        tmux attach
    fi
}

### End custom section ###
