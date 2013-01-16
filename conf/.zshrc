HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
zstyle :compinstall filename '/Users/rkautz/.zshrc'

export PATH=$PATH:$HOME/.bin
export EDITOR="mvim -v"
fpath=(~/.zsh_completion ~/.zsh/zsh-completions/src/ $fpath)

autoload -Uz compinit
compinit
autoload -U colors
colors

alias vim='mvim -v'

source ~/.dotfiles/prompt
source ~/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

