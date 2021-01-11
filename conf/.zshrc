# completion
fpath+=~/.zfunc
compinit

export WORDCHARS='*?_-~=&;!#$%^(){}<>'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#AAAAAA,underline"

if [[ -n $SSH_CONNECTION  ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
fi
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# make vim fzf plugin use ripgrep
export FZF_DEFAULT_COMMAND='rg --files'

# key bindings
## make C-u behave like in bash
bindkey \^U backward-kill-line

# convinence
alias ls='ls --color'
alias ll='lsd -l'
alias la='lsd -a'
alias git='LANG=en_US git'
alias vim='nvim'
alias qvim='nvim-qt 2> /dev/null'
alias tmux-cwd='tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias xclip='xclip -selection clipboard'
alias sudo='sudo -v; sudo '
alias wanip='curl -s ifconfig.me'
alias brightness='pkexec --user root xfpm-power-backlight-helper --set-brightness'
alias windowclass='xprop | grep WM_CLASS | awk "{print \$4}"'

# speciffic
alias dc='source dev.env && docker-compose -p gdn -f compose-dev.yml'

# credentials
test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# linuxbrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# kubectl
source <(kubectl completion zsh)
source <(helm completion zsh)

# AWS
complete -C '/usr/bin/aws_completer' aws

# prompt
eval "$(starship init zsh)"

# better cd
eval "$(zoxide init zsh)"

# GTK3 includes
source <(pkg-config --cflags-only-I --libs gtk+-3.0 | sed 's/ *-I/\nexport CPATH=$CPATH:/g' | tail -n+2 | head -n -1)

# temporary stuff
source $HOME/.zshrc.local.d/*

