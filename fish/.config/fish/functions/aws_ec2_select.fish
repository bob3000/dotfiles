function aws_ec2_select --description "Get EC2 instance information"
    set -f col $(aws-ec2-describe | fzf --prompt 'Instance> ' --ansi \
    --header 'InstanceId <enter> / IP <alt-i> / Public IP <alt-p> / Name <alt-n>' \
    --bind 'enter:become(echo {1})' \
    --bind 'alt-i:become(echo {2})' \
    --bind 'alt-p:become(echo {3})' \
    --bind 'alt-n:become(echo {4})')
    printf "%s" $col
end
