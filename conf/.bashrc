# git
export GIT_PS1_SHOWDIRTYSTATE=1

export HISTCONTROL=ignoredups

export SHELL=/bin/bash
export EDITOR="vim"
export GOPATH=$HOME/.go
export PYTHONSTARTUP=$HOME/.pythonstartup
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=~/.local/bin:$PATH
export PATH=~/.gem/ruby/2.3.0/bin:$PATH
if [ -e ~/bin ]; then
    while read d; do
        export PATH="${d}:$PATH"
    done < <(find ~/bin -type d)
fi
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
alias vpnupdate='wget -O ~/Documents/vpn/ovpn.zip https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip && unzip -qo ~/Documents/vpn/ovpn.zip -d ~/Documents/vpn/'

function vpnup {
    local region="${1:-de}"
    local protocol="${2:-udp}"
    local configs_dir=${3:-~/Documents/vpn/ovpn_}${protocol}
    local authfile=~/.vpnauth
    local errmsg="no servers $protocol servers found in region $region"
    declare -a servers
    servers=( $(ls "${configs_dir}/" | grep -E "^$region" || (echo "$errmsg" > /dev/stderr && exit 1)) )
    choice=$(( RANDOM % ${#servers[@]} ))
    sudo openvpn --config "${configs_dir}/${servers[$choice]}" --auth-user-pass ${authfile}
}

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

# prompt
# Only load liquidprompt in interactive shells, not from a script or from scp
if [ -f /home/linuxbrew/.linuxbrew/share/liquidprompt ]; then
    . /home/linuxbrew/.linuxbrew/share/liquidprompt
fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

complete -C aws_completer aws

test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib/pkgconfig"

