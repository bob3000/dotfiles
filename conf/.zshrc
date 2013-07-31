HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"

export PATH=$PATH:$HOME/.bin:/opt/local/bin
export EDITOR="mvim -v"
export PYTHONSTARTUP=$HOME/.pythonstartup
fpath=(~/.zsh_completion ~/.dotfiles/zsh-completions/src/ $fpath)

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1	# Because we didn't really complete anything
}
zstyle ':completion:*' _force_rehash

autoload -Uz compinit
compinit
autoload -U colors
colors

alias vim='mvim -v'
alias kuka='curl http://www.kuka-berlin.de/mittagstisch/ | html2text'

source ~/.dotfiles/conf/.zsh/prompt
source ~/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

