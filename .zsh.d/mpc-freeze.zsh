function mpc-freeze() {
    mpc -f '%file%' \
        | perl -pe '$.==2 && s/^.*\s(\d+:\d+)\/.*$/$1/;' \
                -e '$.==3 && last;'
}

function mpc-thaw() {
    read f
    read p
    mpc clear
    mpc add "$f"
    mpc play
    mpc seek "$p"
}

function mpc-get() {
    ssh "$1" 'zsh -c "source ~/.zsh.d/mpc-freeze.zsh;mpc-freeze"' | mpc-thaw
}
