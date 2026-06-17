function aws_assume_role --description "Assume IAM role"
    set -f role $argv[1]
    if [ -z $role ]
        set -f role $(aws iam list-roles --max-items 1000 --query "Roles[*].Arn" --output text | tr '[:space:]' '\n' | fzf --prompt 'Role> ' --ansi)
    end
    aws sts assume-role \
        --role-arn $role \
        --role-session-name "rkautz-$(date '+%s')" \
        | jq -r '.Credentials | "set -x AWS_ACCESS_KEY_ID \(.AccessKeyId)\nset -x AWS_SECRET_ACCESS_KEY \(.SecretAccessKey)\nset -x AWS_SESSION_TOKEN \(.SessionToken)"' \
        | source
    commandline --function repaint
end
