set fish_greeting

# fisher install decors/fish-colored-man
# fisher install edc/bass
# fisher install jomik/fish-gruvbox
# fisher install jorgebucaran/autopair.fish
# fisher install jorgebucaran/nvm.fish
# fisher install jorgebucaran/replay.fish
# fisher install 2m/fish-history-merge
# fisher install PatrickF1/fzf.fish

# fish fzf stttings
function preview_files
    if [ $(file --mime "$argv" | cut -d'=' -f2) = binary ]
        chafa --format kitty --animate=off --center on --clear --size "$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES" "$argv" 2>/dev/null
    else
        bat --style=numbers --color=always "$argv"
    end
end
set fzf_preview_file_cmd preview_files
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_preview_dir_cmd eza --all --color=always --tree

set --export PYENV_ROOT $HOME/.pyenv

if set -q $SSH_CONNECTION
    set EDITOR vim
else
    set EDITOR nvim
end
set --export OSTYPE (uname)
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export PAGER less
set --export BROWSER brave
set --export TERMINAL kitty
set --export GOPATH $HOME/.go
set --export PATH "$GOPATH/bin:$PATH"
set --export PATH "/usr/local/bin:$PATH"
set --export PATH "$HOME/.cargo/bin:$PATH"
set --export PATH "$HOME/.local/bin:$PATH"
set --export PATH "$HOME/.dotnet/tools:$PATH"
set --export PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
set --export PATH "$PYENV_ROOT/bin:$PATH"

# set --export PATH "/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

set --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --bind ctrl-k:preview-up,ctrl-j:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
set --export FZF_DEFAULT_COMMAND 'rga --files'
set --export FZF_CTRL_T_COMMAND 'fd --color always --exclude "Library/*" . $HOME'
set --export FZF_CTRL_T_OPTS '--ansi --multi --prompt="File> " --preview "preview_files {}"'
set --export FZF_ALT_C_COMMAND 'fd --color always --exclude "Library/*" -t d . $HOME'
set --export FZF_ALT_C_OPTS '--ansi --multi --prompt="Directory> " --preview "eza --color always -la {}"'

# man colors
set -g man_blink -o red
set -g man_bold -o green
set -g man_standout -b black 93a1a1
set -g man_underline -u 93a1a1

# convenience
alias wiki 'cd ~/Nextcloud/Synced/wiki/ && tmux new-session -A -s wiki "nvim index.md"'
alias l 'eza --icons'
alias ll 'eza -l --icons'
alias lt 'eza --tree'
alias la 'eza -a --icons'
alias tmux-cwd 'tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias wanip 'curl -s ifconfig.me'
alias icat "kitty +kitten icat"
alias d "kitty +kitten diff"
alias emoji "kitty +kitten unicode_input"
alias tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# credentials
test -e "$HOME/.credentials" && source "$HOME/.credentials"

if test -n $appearance
  set -U appearance dark
end
function toggle_theme
  [ $appearance = "dark" ] && set -U appearance light || set -U appearance dark
  set -f kitty_socket $HOME/.local/state
  set -f kitty_theme "Everforest $appearance Soft"
  set -f nvim_socket $HOME/.cache/nvim
  for f in $kitty_socket/kitty-*
    kitten @ --to unix:$f kitten themes "$kitty_theme"
  end
  for f in $nvim_socket/nvim-*
    nvim --server $f --remote-send ':set background='$appearance'<cr>' 2>&1 > /dev/null
  end
  if type -q osascript
    [ $appearance = "dark" ] && set -f dark_mode "true" || set -f dark_mode "false"
    osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to $dark_mode"
  end
  if type -q gsettings
    gsettings set org.gnome.desktop.interface color-scheme "prefer-$appearance"
  end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    function starship_transient_rprompt_func
        starship module time
    end
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
    fzf_key_bindings
    fnm env --use-on-cd | source # fast node manager
    pyenv init - | source
    # theme_gruvbox dark medium
end

# key bindings
bind \cr _fzf_search_history
bind \e\cm 'toggle_theme; commandline -f repaint'
fzf_configure_bindings --variables=\e\cv
