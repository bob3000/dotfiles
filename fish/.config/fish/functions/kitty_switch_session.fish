function kitty_switch_session --description "Switch Kitty sessions"
    set -f session "$(ls ~/.local/share/kitty/sessions | sed s/.kitty-session// | fzf --prompt 'Session> ' --ansi | tr -d '[:space:]')"
    if test -n "$session"
        kitten @ action goto_session "$session.kitty-session"
    end
    commandline --function repaint
end
