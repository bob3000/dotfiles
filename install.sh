#!/bin/bash
set -eu

declare -A source_files=( [bashrc]=.bashrc [gitconfig]=.gitconfig \
    [liquidpromptrc]=.liquidpromptrc [pythonstartup]=.pythonstartup \
    [tmux]=.tmux.conf [vim]=init.vim )
declare -A target_dirs=( [bashrc]=~/.bashrc [gitconfig]=~/.gitconfig \
    [liquidpromptrc]=~/.liquidpromptrc [pythonstartup]=~/.pythonstartup \
    [tmux]=~/.tmux.conf [vim]=~/.config/nvim/init.vim )

for file in ${!source_files[@]}; do
    skip_file=0
    echo "linking conf/${source_files[$file]} -> ${target_dirs[$file]}"
    if [ -f ${target_dirs[$file]} ]; then
        declare choice
        valid_choice=0
        while [ 0 -eq $valid_choice ]; do
            read -p "File ${source_files[$file]} exists. rename/delete/abort? [r,d,s] " choice
            case $choice in
                r)
                    echo "renaming to ${target_dirs[$file]}.bak"
                    mv ${target_dirs[$file]} ${target_dirs[$file]}.bak
                    valid_choice=1
                    ;;
                d)
                    echo "deleting ..."
                    rm ${target_dirs[$file]}
                    valid_choice=1
                    ;;
                s)
                    echo "skipping ..."
                    skip_file=1
                    valid_choice=1
                    ;;
                *)
                    echo "invalid input"
                    ;;
            esac
        done
    fi
    if [ 0 -eq $skip_file ]; then
        # create parent directory if necessary
        if echo ${target_dirs[$file]} | sed -e "s#$HOME/##" | grep -q '/'; then
            mkdir -p $(echo ${target_dirs[$file]} | awk -F'/' 'END{gsub($NF, ""); print}')
        fi
        ln -s $(pwd)/conf/${source_files[$file]} ${target_dirs[$file]}
    fi
done
