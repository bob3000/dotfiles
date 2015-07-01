export HISTCONTROL=ignoredups

# git
export GIT_PS1_SHOWDIRTYSTATE=1

# console colors
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

export GOPATH=$HOME/.go
export EDITOR="mvim -v"
export PYTHONSTARTUP=$HOME/.pythonstartup
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

#export AWS_ACCESS_KEY="$(awk '/aws_access_key_id/{print $3}' ~/.aws/credentials)"
#export AWS_SECRET_KEY="$(awk '/aws_secret_access_key/{print $3}' ~/.aws/credentials)"
export VAGRANT_TOKEN="$(cat ~/.vagrant.d/data/vagrant_login_token 2> /dev/null)"
export SLACK_TOKEN="$(cat ~/.slack_token)"
export VAGRANT_NUM_INSTANCES=3
export DOCKER_HOST=tcp://127.0.0.1:2375

$(/usr/local/bin/boot2docker shellinit 2> /dev/null)

export CDPATH=.:/Users/robin/devel

# convinence
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias pt='pygmentize'
alias git='LANG=en_US git'
alias vim='/usr/local/bin/gvim -v'

alias vmsoff='VBoxManage list runningvms | sed -ne "s/.*{\(.*\)}/\1/gp" | xargs -I {} -n1 VBoxManage controlvm {} poweroff'
alias vmsrunning='VBoxManage list runningvms'
alias vmsall='VBoxManage list vms'

alias spf13='curl https://j.mp/spf13-vim3 -L -o - | sh'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

for i in /usr/local/etc/bash_completion.d/*; do
    source $i
done
complete -C aws_completer aws
source /usr/local/share/liquidprompt
export AWS_MFA_SERIAL='arn:aws:iam::642788012356:mfa/robin'
source ~/devel/canstorage/code/aws_accout_switch/aws_account_switch.bashrc
