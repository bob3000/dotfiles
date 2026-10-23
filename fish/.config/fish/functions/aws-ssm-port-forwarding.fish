function aws-ssm-port-forwarding --description "Create SSM tunnel to forward a port"
    aws ssm start-session \
        --target "$argv[1]" \
        --document-name AWS-StartPortForwardingSessionToRemoteHost \
        --parameters "{\"host\":[\"$argv[2]\"],\"portNumber\":[\"$argv[3]\"],\"localPortNumber\":[\"$argv[4]\"]}"
end
