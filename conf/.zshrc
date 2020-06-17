# completion
fpath+=~/.zfunc
compinit

if [[ -n $SSH_CONNECTION  ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
fi
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# convinence
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias git='LANG=en_US git'
alias vim='nvim'
alias tmuxa='tmux attach'
alias xclip='xclip -selection clipboard'

alias wanip='curl -s ifconfig.me'

# credentials
test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# linuxbrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# kubectl
source <(kubectl completion zsh)
source <(helm completion zsh)

# prompt
eval "$(starship init zsh)"

# better cd
eval "$(zoxide init zsh)"

