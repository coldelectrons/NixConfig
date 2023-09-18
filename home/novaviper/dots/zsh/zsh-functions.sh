list-keys() {
    if [ ! -n "$1" ]; then
        echo "Cannot be blank! Parameters must be wezterm,alacritty,tmux"
    elif [ "$1" = "wezterm" ]; then
        xdg-open "https://wezfurlong.org/wezterm/config/default-keys.html" &>/dev/null
    elif [ "$1" = "alacritty" ]; then
        xdg-open "https://github.com/alacritty/alacritty/blob/master/alacritty.yml" &>/dev/null
    elif [ "$1" = "tmux" ]; then
        xdg-open "https://gist.github.com/mzmonsour/8791835#file-tmux-default-bindings-txt" &>/dev/null
    else
        echo "Cannot be blank! Parameters must be wezterm,alacritty,tmux"
    fi
}

reload(){
    clear
    exec zsh
    #source /etc/zsh/zshenv
    #source ${ZDOTDIR:-${HOME}/.config/zsh}/.zshrc
}
