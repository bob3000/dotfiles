set fish_greeting 

if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
  fzf_key_bindings
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

set --universal nvm_default_version lts/hydrogen

# make vim fzf plugin use ripgrep
set FZF_DEFAULT_COMMAND 'rga --files'
set FZF_CTRL_T_COMMAND 'fd . $HOME'
set FZF_CTRL_T_OPTS '--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --color always {}"'
set FZF_ALT_C_COMMAND 'fd -t d . $HOME'
set FZF_ALT_C_OPTS '--preview "exa -la {}"'

# convenience
abbr ls 'ls --color'
abbr ll 'exa -l'
abbr la 'exa -a'
abbr tmux-cwd 'tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
abbr sudo 'sudo -v; sudo '
abbr wanip 'curl -s ifconfig.me'
abbr neovide 'neovide --multigrid -- -u ~/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=~/.local/share/lunarvim/lvim"'
abbr icat "kitty +kitten icat"
abbr d "kitty +kitten diff"
abbr emoji "kitty +kitten unicode_input"

# credentials
test -e "$HOME/.credentials" && source "$HOME/.credentials"
