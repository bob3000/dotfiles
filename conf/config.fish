set fish_greeting

# fisher install decors/fish-colored-man
# fisher install jomik/fish-gruvbox
# fisher install jorgebucaran/autopair.fish
# fisher install jorgebucaran/nvm.fish
# fisher install jorgebucaran/replay.fish

if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
  fzf_key_bindings
  theme_gruvbox dark medium
end

if set -q $SSH_CONNECTION
    set EDITOR 'nvim'
  else
    set EDITOR 'vim'
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

set nvm_default_version lts/hydrogen

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
abbr ls 'ls --color'
abbr ll 'exa -l'
abbr la 'exa -a'
abbr tmux-cwd 'tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
abbr sudo 'sudo -v; sudo '
abbr wanip 'curl -s ifconfig.me'
abbr icat "kitty +kitten icat"
abbr d "kitty +kitten diff"
abbr emoji "kitty +kitten unicode_input"

# credentials
test -e "$HOME/.credentials" && source "$HOME/.credentials"

switch (uname)
  case Darwin
    source /opt/homebrew/etc/grc.fish
  case Linux
    eval (grc-rs --aliases)
end
