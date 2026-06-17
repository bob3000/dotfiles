function aws-ec2-describe --description "Describe running EC2 instances"
    aws ec2 describe-instances \
        --filters 'Name=instance-state-name,Values=running' \
        --query 'Reservations[].Instances[].[InstanceId, PrivateIpAddress, PublicIpAddress, Tags[?Key==`Name`].Value | [0]]' \
        --output text | column -t
end
