function aws_switch_profile --description "Switch AWS profile"
    set -f profile "$(aws-vault list --profiles | fzf --prompt 'Profile> ' --ansi | tr -d '[:space:]')"
    if test -n "$profile"
        aws-vault exec --duration=12h "$profile"
    end
    commandline --function repaint
end
