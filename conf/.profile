# MacPorts Installer addition on 2011-12-01_at_11:26:35: adding an appropriate PATH variable for use with MacPorts.
export PATH=/Users/rkautz/bin:/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export C_INCLUDE_PATH=/opt/local/include
export LIBRARY_PATH=/opt/local/lib

# git
export GIT_PS1_SHOWDIRTYSTATE=1

# console colors
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

export PATH=$HOME/.dotfiles/bin:/opt/local/bin:$PATH
export PATH=/opt/local/libexec/gnubin:$PATH
export EDITOR="mvim -v"
export PYTHONSTARTUP=$HOME/.pythonstartup

# MacPorts Bash shell command completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

# git completion
if [ -f /opt/local/share/git-core/git-prompt.sh ]; then
    . /opt/local/share/git-core/git-prompt.sh
fi

# other completion
if [ -d /etc/bash_completion.d ]; then
    . /etc/bash_completion.d/*
fi

# convinence
alias ll='ls -l'
alias la='ls -a'
alias pt='pygmentize'
alias git='LANG=en_US git'

alias vim='~/.dotfiles/bin/mvim -v'
alias kuka='curl http://www.kuka-berlin.de/mittagstisch/ | html2text'

## prompt
source ~/.dotfiles/liquidprompt/liquidprompt
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

## completions
[ -f /etc/bash_completion.d/git-devbliss ] && source /etc/bash_completion.d/git-devbliss
source ~/.dotfiles/vagrant-bash-completion/vagrant
source ~/.dotfiles/bash_completion/tmux

