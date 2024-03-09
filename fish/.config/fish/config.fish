set fish_greeting

# fisher install decors/fish-colored-man
# fisher install PatrickF1/fzf.fish

# fish fzf stttings
function preview_files
    if [ $(file --mime "$argv" | cut -d'=' -f2) = binary ]
        chafa --format kitty --animate=off --center on --clear --size "$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES" "$argv" 2>/dev/null
    else
        bat --style=numbers --color=always "$argv"
    end
end

set script_pwd (dirname (status --current-filename))
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
set --export TTY /dev/(ps -p $fish_pid -o tty=)
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
command -q luarocks && eval "$(luarocks path --bin)"

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
    [ $appearance = dark ] && set -U appearance light || set -U appearance dark
    set -f kitty_socket $HOME/.local/state
    set -f kitty_theme "Everforest $appearance Hard"
    set -f nvim_socket $HOME/.cache/nvim
    for f in $kitty_socket/kitty-*
        kitten @ --to unix:$f kitten themes "$kitty_theme"
    end
    for f in $nvim_socket/nvim-*
        nvim --server $f --remote-send ':set background='$appearance'<cr>' 2>&1 >/dev/null
    end
    if type -q osascript
        [ $appearance = dark ] && set -f dark_mode true || set -f dark_mode false
        osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to $dark_mode"
    end
    if type -q gsettings
        gsettings set org.gnome.desktop.interface color-scheme "prefer-$appearance"
    end
end

if ! command -q docker
  alias docker podman
end

if test -d /home/linuxbrew/.linuxbrew
    # Homebrew is installed on Linux
    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
    set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
    set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
    set -gx PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH

    # Homebrew asked for this in order to `brew upgrade`
    # set -gx HOMEBREW_GITHUB_API_TOKEN {api token goes here}
else if test -d /opt/homebrew
    # Homebrew is installed on MacOS
    /opt/homebrew/bin/brew shellenv | source
    set -gx PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
    set -gx DYLD_LIBRARY_PATH /opt/homebrew/Cellar/imagemagick/7.1.1-29_1/lib
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    function starship_transient_rprompt_func
        starship module time
    end
    function starship_transient_prompt_func
        starship module character
    end
    if command -q starship
        starship init fish | source
        enable_transience
    end
    command -q fnm && fnm env --use-on-cd | source # fast node manager
    command -q pyenv && pyenv init - | source

    # key bindings
    bind \cr _fzf_search_history
    bind \e\cm 'toggle_theme; commandline -f repaint'
    fzf_configure_bindings
    fzf_configure_bindings --variables=\e\cv
    source $script_pwd/functions/fzf_default_bindings.fish
    fzf_key_bindings
    if type -q aws_completer
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end
end
