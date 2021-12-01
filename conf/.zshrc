# completion
fpath+=~/.zfunc
compinit

export WORDCHARS='*?_-~=&;!#$%^(){}<>'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#AAAAAA,underline"

if [[ -n $SSH_CONNECTION  ]]; then
    export EDITOR='nvim'
  else
    export EDITOR='vim'
fi
export BROWSER=firefox
export TERMINAL=kitty
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# vim
# make vim fzf plugin use ripgrep
export FZF_DEFAULT_COMMAND='rga --files'
export FZF_CTRL_T_COMMAND='fd . $HOME'
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --color always {}"'
export FZF_ALT_C_COMMAND='fd -t d . $HOME'
export FZF_ALT_C_OPTS='--preview "exa -la {}"'
export NeovideMultiGrid=1

export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-/home/bob/.config/lvim}"
export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-/home/bob/.local/share/lunarvim}"

# key bindings
## make C-u behave like in bash
bindkey '^U' backward-kill-line

# convinence
alias ls='ls --color'
alias ll='lsd -l'
alias la='lsd -a'
alias git='LANG=en_US git'
alias open='xdg-open'
# alias vim='nvim'
alias qvim='nvim-qt 2> /dev/null'
alias tmux-cwd='tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias xclip='xclip -selection clipboard'
alias sudo='sudo -v; sudo '
alias wanip='curl -s ifconfig.me'
alias brightness='pkexec --user root xfpm-power-backlight-helper --set-brightness'
alias windowclass='xprop | grep WM_CLASS | awk "{print \$4}"'

# enable completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

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

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# temporary stuff
source $HOME/.zshrc.local.d/*

