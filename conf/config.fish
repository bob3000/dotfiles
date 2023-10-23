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
    set -f size (wezterm cli list | awk -vc="$(wezterm cli list-clients | awk 'NR==2{print $NF}')" '$3==c{split($5,a,"x");print int(a[1]/2-6)"x"a[2]}')
    chafa --format kitty --animate=off --center on --clear --size $size "$argv" 2> /dev/null
    # viu --static --transparent --height (echo $size | cut -d'x' -f2) --width (echo $size | cut -d'x' -f1) "$argv"
    # wezterm imgcat --height (echo $size | cut -d'x' -f2) --width (echo $size | cut -d'x' -f1) "$argv"
    # kitty +kitten icat --transfer-mode=file --stdin=no --place="$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES"@0x0 "$argv"
    # cat "$argv" | convert -scale $size - - | kitty +kitten icat --transfer-mode=file --stdin=yes
  else
    bat --style=numbers --color=always --theme gruvbox-dark "$argv"
  end
end
set fzf_preview_file_cmd preview_files
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_preview_dir_cmd eza --all --color=always --tree

if set -q $SSH_CONNECTION
    set EDITOR vim
else
    set EDITOR nvim
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
set PATH "$HOME/.dotnet/tools:$PATH"
set PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
# set PATH "/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# make vim fzf plugin use ripgrep
set FZF_DEFAULT_COMMAND 'rga --files'
set FZF_CTRL_T_COMMAND 'fd --exclude "Library/*" . $HOME'
set FZF_CTRL_T_OPTS '--preview "[ $(file --mime {} | cut -d'=' -f2) = binary ] && echo {} is a binary file || bat --color always {}"'
set FZF_ALT_C_COMMAND 'fd --exclude "Library/*" -t d . $HOME'
set FZF_ALT_C_OPTS '--preview "eza -la {}"'

set -x NEOVIDE_MULTIGRID true

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
    theme_gruvbox dark medium
end

# key bindings
bind \er ranger # start ranger file manager
