# completion
fpath+=~/.zfunc
#compinit

export WORDCHARS='*?_-~=&;!#$%^(){}<>'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#AAAAAA,underline"

if [[ -n $SSH_CONNECTION  ]]; then
    export EDITOR='nvim'
  else
    export EDITOR='vim'
fi
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PAGER=bat
export BROWSER=brave
export TERMINAL=kitty
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# make vim fzf plugin use ripgrep
export FZF_DEFAULT_COMMAND='rga --files'
export FZF_CTRL_T_COMMAND='fd --exclude "Library/*" . $HOME'
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --color always {}"'
export FZF_ALT_C_COMMAND='fd --exclude "Library/*" -t d . $HOME'
export FZF_ALT_C_OPTS='--preview "eza -la {}"'

# key bindings
## make C-u behave like in bash
bindkey '^U' backward-kill-line

# convenience
alias ls='ls --color'
alias ll='eza -l'
alias la='eza -a'
alias git='LANG=en_US git'
alias tmux-cwd='tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias sudo='sudo -v; sudo '
alias wanip='curl -s ifconfig.me'
alias neovide='neovide --multigrid'
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"
alias emoji="kitty +kitten unicode_input"

# enable completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# credentials
test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# prompt
eval "$(starship init zsh)"

# temporary stuff
test -d "${HOME}/.zshrc.local.d" && source $HOME/.zshrc.local.d/*

if [[ "$OSTYPE" =~ ^darwin ]]; then
    source ~/.zshrc.mac
fi

if [[ "$OSTYPE" =~ ^linux ]]; then
    source ~/.zshrc.linux
fi
