export C_INCLUDE_PATH=/opt/local/include
export CFLAGS=-I/opt/local/include
export LIBRARY_PATH=/opt/local/lib
export LINKFLAGS=-L/opt/local/lib

export HISTCONTROL=ignoredups

# git
export GIT_PS1_SHOWDIRTYSTATE=1

# console colors
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

export GOPATH=$HOME/.go
export PATH=${GOPATH//://bin:}/bin:$HOME/Library/Python/3.2/bin:$HOME/.dotfiles/bin:/opt/local/bin:$PATH
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
if [ -f /opt/local/share/git-core/contrib/completion/git-completion.bash ]; then
    . /opt/local/share/git-core/contrib/completion/git-completion.bash
fi

# other completion
if [ -d /etc/bash_completion.d ]; then
    for c in /etc/bash_completion.d/*; do source $c; done
fi
if [ -d /opt/local/etc/bash_completion.d ]; then
    for c in /opt/local/etc/bash_completion.d/*; do source $c; done
fi

# convinence
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias pt='pygmentize'
alias git='LANG=en_US git'
alias ack='ack-5.12'

alias vmsoff='for line in $(VBoxManage list runningvms | sed -ne "s/.*{\(.*\)}/\1/gp"); do VBoxManage controlvm  $line poweroff; done;'
alias vmsrunning='VBoxManage list runningvms'
alias vmsall='VBoxManage list vms'

alias vim='~/.dotfiles/bin/mvim -v'
alias kuka='curl http://www.kuka-berlin.de/mittagstisch/ | html2text'

alias picdorian='rsync -n --exclude=".AppleDouble" --exclude=".DS_Store" --progress -rtvz ~/Pictures/Pictures/ /Volumes/private/Pictures/'
alias pichidrive='rsync -n --exclude=".AppleDouble" --exclude=".DS_Store" --progress -rtvze "ssh" ~/Pictures/Pictures robinkautz@rsync.hidrive.strato.com:/users/robinkautz/'

## prompt
source ~/.dotfiles/liquidprompt/liquidprompt
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

## completions
[ -f /etc/bash_completion.d/git-devbliss ] && source /etc/bash_completion.d/git-devbliss
source ~/.dotfiles/vagrant-bash-completion/etc/bash_completion.d/vagrant
source ~/.dotfiles/bash_completion/tmux
source ~/.dotfiles/bash_completion/tmuxinator.bash
