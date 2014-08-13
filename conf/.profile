export HISTCONTROL=ignoredups

# git
export GIT_PS1_SHOWDIRTYSTATE=1

export GOPATH=$HOME/.go
export EDITOR="vim"
export PYTHONSTARTUP=$HOME/.pythonstartup

# convinence
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias pt='pygmentize'
alias git='LANG=en_US git'

alias vmsoff='for line in $(VBoxManage list runningvms | sed -ne "s/.*{\(.*\)}/\1/gp"); do VBoxManage controlvm  $line poweroff; done;'
alias vmsrunning='VBoxManage list runningvms'
alias vmsall='VBoxManage list vms'

alias spf13='curl https://j.mp/spf13-vim3 -L -o - | sh'

alias picdorian='rsync -n --exclude=".AppleDouble" --exclude=".DS_Store" --progress -rtvz ~/Pictures/Pictures/ /Volumes/private/Pictures/'
alias pichidrive='rsync -n --exclude=".AppleDouble" --exclude=".DS_Store" --progress -rtvze "ssh" ~/Pictures/Pictures robinkautz@rsync.hidrive.strato.com:/users/robinkautz/'
