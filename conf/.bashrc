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
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools/
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH=/opt/puppetlabs/pdk/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
export C_INCLUDE_PATH="$C_INCLUDE_PATH:/usr/local/include"

# convinence
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias git='LANG=en_US git'
alias vim='nvim'
alias flushdns='sudo killall -HUP mDNSResponder'

alias vmsoff='VBoxManage list runningvms | sed -ne "s/.*{\(.*\)}/\1/gp" | xargs -I {} -n1 VBoxManage controlvm {} poweroff'
alias vmsrunning='VBoxManage list runningvms'
alias vmsall='VBoxManage list vms'

alias wanip='curl -s ifconfig.me'
alias pichidrive='rsync -n --exclude=".AppleDouble" --exclude=".DS_Store" --progress -rtvze "/usr/local/bin/ssh" /Volumes/My\ Passport/Pictures robinkautz@rsync.hidrive.strato.com:/users/robinkautz/'

# bgf
alias dcf='docker-compose -f docker-compose.yml -f docker-compose.backend.yml -f docker-compose.frontend.yml'
alias dca='docker-compose -f docker-compose.yml -f docker-compose.backend.yml -f docker-compose.bergwacht.yml -f docker-compose.frontend.yml'

# prompt
source /usr/local/share/liquidprompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
complete -C aws_completer aws
which -s kubectl && source <(kubectl completion bash)
which -s kompose && source <(kompose completion bash)

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# credentials
test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# functions
function android_emulator {
    EMULATOR_NAME=$1
    if [ -z $EMULATOR_NAME ]; then
        emulator -list-avds
        return
    fi
    pushd ${ANDROID_HOME}/tools
    emulator -avd ${EMULATOR_NAME} -wipe-data &
    popd
}

