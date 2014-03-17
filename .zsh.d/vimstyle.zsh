# Vim-style commands

alias ':e'=vim
alias ':q'=exit
alias ':r'=r
function :sp {
  if (( $# == 0 ))
  then
    uxterm -tn "$TERM" -e "cd \"$PWD\" && $SHELL" &!
  else
    if [ -d "$1" ]
    then
      uxterm -tn "$TERM" -e "cd \"$1\" && $SHELL" &!
    else
      dir=$(dirname $1)
      file=$(basename $1)
      uxterm -tn "$TERM" -e "cd $dir && vim $file" &!
    fi
  fi
}
