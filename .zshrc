setopt autopushd

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Prompt {{{
autoload -Uz promptinit
promptinit
prompt walters
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}•%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats ' [%b%u%c]'
zstyle ':vcs_info:*' actionformats ' [%b%u%c]'
precmd () { vcs_info }
setopt prompt_subst

PROMPT='%F{cyan}%n@%m %~$vcs_info_msg_0_ %# %f'
RPROMPT=''
# }}}
# History {{{
HISTSIZE=10000 
SAVEHIST=10000 
HISTFILE=~/.zsh_history
# }}}
# Completion {{{
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# }}}
# Vim-style commands {{{
alias ':e'=vim
alias ':q'=exit
function :sp {
  if (( $# == 0 ))
  then
    uxterm -tn "$TERM" -e "cd $PWD && $SHELL" &!
  else
    uxterm -tn "$TERM" -e "cd $1 && vim" &!
  fi
}
# }}}
# Command aliases {{{
alias ls='ls -F --color=auto' 

# Don't try to expand '?' in URLs
alias youtube-dl='noglob youtube-dl'
# }}}
# Suffix aliases {{{
alias -s -- pdf=zathura
alias -s -- ps=evince
alias -s -- git='git clone'
# }}}
# Other aliases {{{
mdcd ()
{
  mkdir -p "$1"
  cd "$1"
}

git(){
  hub "$@"
}
# }}}
# C-x C-e opens $EDITOR {{{
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
# }}}
# Ctrl-Arrows move word by word {{{
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word
# }}}

# Load ~/.zsh.d/* {{{
for zshrc_snipplet in ~/.zsh.d/* ; do
  source $zshrc_snipplet
done
# }}}
