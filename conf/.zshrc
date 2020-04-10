# Path to your oh-my-zsh installation.
export ZSH="/Users/bob/.oh-my-zsh"

ZSH_THEME="ys"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting virtualenv colored-man-pages dircycle history-substring-search docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# History
HISTSIZE=10000
SAVEHIST=10000
setopt histignorespace
setopt hist_ignore_all_dups
setopt append_history
setopt share_history

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export ARCHFLAGS="-arch x86_64"
export SHELL=/usr/local/bin/zsh
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

# credentials
test -e "${HOME}/.credentials" && source "${HOME}/.credentials"

# Basic auto/tab complete:
fpath+=~/.zfunc
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# use the vi navigation keys in menu completion
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-xe:
autoload edit-command-line; zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# beam shaped cursor
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# auto completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

~/.iterm2_shell_integration.zsh

