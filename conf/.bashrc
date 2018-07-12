# git
export GIT_PS1_SHOWDIRTYSTATE=1

export HISTCONTROL=ignoredups

# console colors
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

export SHELL=/usr/local/bin/bash
export EDITOR="nvim"
export GOPATH=$HOME/.go
export PYTHONSTARTUP=$HOME/.pythonstartup
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools/
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# convinence
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias git='LANG=en_US git'
alias vim='nvim'

alias vmsoff='VBoxManage list runningvms | sed -ne "s/.*{\(.*\)}/\1/gp" | xargs -I {} -n1 VBoxManage controlvm {} poweroff'
alias vmsrunning='VBoxManage list runningvms'
alias vmsall='VBoxManage list vms'

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias pichidrive='rsync -n --exclude=".AppleDouble" --exclude=".DS_Store" --progress -rtvze "ssh" /Volumes/My\ Passport/Pictures robinkautz@rsync.hidrive.strato.com:/users/robinkautz/'

# prompt
source /usr/local/share/liquidprompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
complete -C aws_completer aws

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

test -e "${HOME}/.credentials" && source "${HOME}/.credentials"
