function aws_ec2_select_replace --description "replace the current command token"
    set -f output (aws_ec2_select)
    commandline --current-token --insert -- (string escape -- $output | string join ' ')
    commandline --function repaint
end
