HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
zstyle :compinstall filename '/Users/rkautz/.zshrc'

export PATH=$PATH:$HOME/.bin
export EDITOR="mvim -v"
export PYTHONSTARTUP=$HOME/.pythonstartup
fpath=(~/.zsh_completion ~/.dotfiles/zsh-completions/src/ $fpath)

autoload -Uz compinit
compinit
autoload -U colors
colors

alias vim='mvim -v'

source ~/.dotfiles/conf/.zsh/prompt
source ~/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

