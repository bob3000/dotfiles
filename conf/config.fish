set fish_greeting

# fisher install decors/fish-colored-man
# fisher install edc/bass
# fisher install jomik/fish-gruvbox
# fisher install jorgebucaran/autopair.fish
# fisher install jorgebucaran/nvm.fish
# fisher install jorgebucaran/replay.fish

if set -q $SSH_CONNECTION
    set EDITOR 'vim'
  else
    set EDITOR 'nvim'
end
set LC_ALL en_US.UTF-8
set LANG en_US.UTF-8
set PAGER less
set BROWSER brave
set TERMINAL kitty
set GOPATH $HOME/.go
set PATH "$GOPATH/bin:$PATH"
set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/.local/bin:$PATH"

# make vim fzf plugin use ripgrep
set FZF_DEFAULT_COMMAND 'rga --files'
set FZF_CTRL_T_COMMAND 'fd . $HOME'
set FZF_CTRL_T_OPTS '--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --color always {}"'
set FZF_ALT_C_COMMAND 'fd -t d . $HOME'
set FZF_ALT_C_OPTS '--preview "exa -la {}"'

# man colors
set -g man_blink -o red
set -g man_bold -o green
set -g man_standout -b black 93a1a1
set -g man_underline -u 93a1a1

# convenience
alias wiki 'cd ~/Nextcloud/Synced/wiki/ && tmux new-session -A -s wiki "nvim index.md"'
alias ls 'ls --color'
alias ll 'exa -l'
alias lt 'exa --tree'
alias la 'exa -a'
alias tmux-cwd 'tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias wanip 'curl -s ifconfig.me'
alias icat "kitty +kitten icat"
alias d "kitty +kitten diff"
alias emoji "kitty +kitten unicode_input"

# credentials
test -e "$HOME/.credentials" && source "$HOME/.credentials"

if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
  enable_transience
  fzf_key_bindings
  fnm env --use-on-cd | source # fast node manager
  theme_gruvbox dark medium
end

switch (uname)
  case Darwin
    # source /opt/homebrew/etc/grc.fish
  case Linux
    # eval (grc-rs --aliases)
end
