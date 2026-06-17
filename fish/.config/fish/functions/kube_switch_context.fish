function kube_switch_context --description "Switch Kubernetes context"
    set -f context "$(kubectl config get-contexts -o name | fzf --prompt 'Context> ' --ansi | tr -d '[:space:]')"
    if test -n "$context"
        kubectl config use-context "$context"
    end
    commandline --function repaint
end
