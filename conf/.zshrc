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
export USE_POWERLINE="false"
export PAGER=bat
export BROWSER=brave
export TERMINAL=kitty
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/mysql-client/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# vim
# make vim fzf plugin use ripgrep
export FZF_DEFAULT_COMMAND='rga --files'
export FZF_CTRL_T_COMMAND='fd . $HOME'
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --color always {}"'
export FZF_ALT_C_COMMAND='fd -t d . $HOME'
export FZF_ALT_C_OPTS='--preview "exa -la {}"'

# key bindings
## make C-u behave like in bash
bindkey '^U' backward-kill-line

# convenience
alias ls='ls --color'
alias ll='exa -l'
alias la='exa -a'
alias git='LANG=en_US git'
alias tmux-cwd='tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias xclip='xclip -selection clipboard'
alias sudo='sudo -v; sudo '
alias wanip='curl -s ifconfig.me'
alias neovide='neovide --multigrid -- -u ~/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=~/.local/share/lunarvim/lvim"'
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"
alias emoji="kitty +kitten unicode_input"

# functions
## AWS

function awssmart_ssm_connect() {
    echo "Region lookup:" $AWS_REGION
    export customer=$(aws ec2 describe-instances \
                    --query "Reservations[*].Instances[*].{CustomerName:Tags[?Key=='Name']}|[]|[][CustomerName[0].Value]" \
                    --filters Name=instance-state-name,Values=running \
                    --no-paginate --output text | fzf --height=10 --prompt="Select instance> ")
    export instance_id=$(aws ec2 describe-instances \
                        --query 'Reservations[0].Instances[].InstanceId' \
                        --filters Name=instance-state-name,Values=running Name=tag:Name,Values=$customer \
                        --output text;)
   echo "Connecting to: $customer $instance_id"
   aws ssm start-session --target $instance_id
}

# enable completion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# credentials
test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# prompt
eval "$(starship init zsh)"

# node version manager
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# temporary stuff
source $HOME/.zshrc.local.d/*

