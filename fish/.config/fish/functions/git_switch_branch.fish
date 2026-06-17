function git_switch_branch --description "Switch git branch"
    set -f branch "$(git branch --all | grep -v ' *\*' 2> /dev/null | sed 's!remotes/[^/]*/!!g' | sort | uniq | fzf --prompt 'Branch> ' --ansi | tr -d '[:space:]')"
    if test -n "$branch"
        git checkout -q "$branch"
    end
    commandline --function repaint
end
