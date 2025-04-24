set fish_greeting

# fisher install decors/fish-colored-man
# fisher install PatrickF1/fzf.fish

function kube_switch_context --description "Switch Kubernetes context"
    set -f context "$(kubectl config get-contexts -o name | fzf --prompt 'Context> ' --ansi | tr -d '[:space:]')"
    if test -n "$context"
        kubectl config use-context "$context"
    end
    commandline --function repaint
end

function aws_switch_profile --description "Switch AWS profile"
    set -f profile "$(aws-vault list --profiles | fzf --prompt 'Profile> ' --ansi | tr -d '[:space:]')"
    if test -n "$profile"
        aws-vault exec --duration=12h "$profile"
    end
    commandline --function repaint
end

function git_switch_branch --description "Switch git branch"
    set -f branch "$(git branch --all | grep -v ' *\*' 2> /dev/null | sed 's!remotes/[^/]*/!!g' | sort | uniq | fzf --prompt 'Branch> ' --ansi | tr -d '[:space:]')"
    if test -n "$branch"
        git checkout -q "$branch"
    end
    commandline --function repaint
end

function aws-ec2-describe --description "Describe running EC2 instances"
    aws ec2 describe-instances \
        --filters 'Name=instance-state-name,Values=running' \
        --query 'Reservations[].Instances[].[InstanceId, PrivateIpAddress, PublicIpAddress, Tags[?Key==`Name`].Value | [0]]' \
        --output text | column -t
end

function aws_ec2_select --description "Get EC2 instance information"
    set -f col $(aws-ec2-describe | fzf --prompt 'Instance> ' --ansi \
    --header 'InstanceId <enter> / IP <alt-i> / Public IP <alt-p> / Name <alt-n>' \
    --bind 'enter:become(echo {1})' \
    --bind 'alt-i:become(echo {2})' \
    --bind 'alt-p:become(echo {3})' \
    --bind 'alt-n:become(echo {4})')
    printf "%s" $col
end

function aws_ec2_select_replace --description "replace the current command token"
    set -f output (aws_ec2_select)
    commandline --current-token --insert -- (string escape -- $output | string join ' ')
    commandline --function repaint
end

set script_pwd (dirname (status --current-filename))
set fzf_preview_file_cmd fzf-preview.sh
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_preview_dir_cmd eza --all --color=always --tree

set --export PYENV_ROOT $HOME/.pyenv

if set -q $SSH_CONNECTION
    set EDITOR vim
else
    set EDITOR nvim
end
set --export GPG_TTY $(tty)
set --export OSTYPE (uname)
set --export TTY /dev/(ps -p $fish_pid -o tty=)
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export PAGER less
set --export BROWSER brave
set --export TERMINAL kitty
set --export MANPAGER 'nvim +Man!'
set --export GOPATH $HOME/.go
set --export PATH "$GOPATH/bin:$PATH"
set --export PATH "/usr/local/bin:$PATH"
set --export PATH "$HOME/.cargo/bin:$PATH"
set --export PATH "$HOME/.local/bin:$PATH"
set --export PATH "$HOME/.dotnet/tools:$PATH"
set --export PATH "$HOME/.local/share/bob/nightly/nvim-macos-arm64/bin:$PATH"
set --export PATH "$PYENV_ROOT/bin:$PATH"
set --export PATH "$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"
set --export PATH "$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"
set --export PATH "$HOMEBREW_PREFIX/opt/postgresql@*/bin:$PATH"
command -q luarocks && eval "$(luarocks path --bin)"

set --export FZF_DEFAULT_OPTS '--color "bg+:-1:underline,fg+:-1:underline,hl+:-1:underline"'\
' --cycle --layout=reverse --border --height=90% --preview-window=wrap --pointer="" --marker=" "'\
' --bind ctrl-k:preview-up,ctrl-j:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
set --export FZF_DEFAULT_COMMAND 'fd --hidden --type f'
set --export FZF_CTRL_T_COMMAND 'fd --color always --exclude "Library/*" . $HOME'
set --export FZF_CTRL_T_OPTS '--ansi --multi --prompt="File> " --preview "fzf-preview.sh {}"'
set --export FZF_ALT_C_COMMAND 'fd --color always --exclude "Library/*" -t d . $HOME'
set --export FZF_ALT_C_OPTS '--ansi --multi --prompt="Directory> " --preview "eza --color always -la {}"'

# man colors
set -g man_blink -o red
set -g man_bold -o green
set -g man_standout -b black 93a1a1
set -g man_underline -u 93a1a1

# convenience
alias wiki 'cd ~/Nextcloud/Synced/wiki/ && tmux new-session -A -s wiki "nvim index.md"'
alias l 'eza --icons --hyperlink'
alias la 'eza -a --icons --hyperlink'
alias ll 'eza -l --icons --mounts --hyperlink'
alias lla 'eza -la --icons --mounts --hyperlink'
alias lt 'eza --tree --hyperlink'
alias lta 'eza -a --tree --hyperlink'
alias tmux-cwd 'tmux command-prompt -I $PWD -p "New session dir:" "attach -c %1"'
alias wanip 'curl -s ifconfig.me'
alias icat "kitty +kitten icat"
alias d "kitty +kitten diff"
alias emoji "kitty +kitten unicode_input"
alias tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"
alias aws-ssm "aws ssm start-session --target"
alias aws-ssm-user 'test -z $U; and set U ubuntu; aws ssm start-session --document-name AWS-StartInteractiveCommand --parameters command="sudo su -l $U" --target'

type -q direnv && direnv hook fish | source

# credentials
test -e "$HOME/.credentials" && source "$HOME/.credentials"

function toggle_theme
    [ $appearance = dark ] && set -gx appearance light || set -gx appearance dark
    set -f nvim_socket $HOME/.cache/nvim
    for f in $nvim_socket/nvim-*
        nvim --server $f --remote-send ':set background='$appearance'<cr>' 2>&1 >/dev/null
    end
    if [ "$OSTYPE" = Darwin ]
        [ $appearance = dark ] && set -f dark_mode true || set -f dark_mode false
        osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to $dark_mode"
    end
    if [ "$OSTYPE" = Linux ]
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
    # set --export PATH "/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
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
    bind ctrl-r _fzf_search_history
    bind ctrl-alt-g _fzf_grep_current_dir
    bind ctrl-alt-b git_switch_branch
    bind ctrl-alt-a aws_switch_profile
    bind ctrl-alt-k kube_switch_context
    bind ctrl-alt-e aws_ec2_select_replace
    bind ctrl-alt-m 'toggle_theme; commandline -f repaint'
    fzf_configure_bindings --variables=\e\cv
    if type -q aws_completer
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end
end
