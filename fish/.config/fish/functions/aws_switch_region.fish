function aws_switch_region --description "Switch AWS region"
    set -f region "$(aws ec2 describe-regions --query 'Regions[*].[RegionName,Geography[].Name | [0]]' --output text | fzf --prompt 'Region> ' --ansi --bind 'enter:become(echo {1})')"
    if test -n "$region"
        set --global --export AWS_REGION "$region"
        set --global --export AWS_DEFAULT_REGION "$region"
    end
    commandline --function repaint
end
