#!/bin/sh

dependencies=(git curl zsh tmux vim)
bak_dir=~/.dotfiles-bak
repo=~/.dotfiles
github=git@github.com:bob3000/dotfiles.git

# check dependencies
for d in $dependencies; do
    if ! which $d; then
        echo "Error: $d is not installed" >> /dev/stderr
        exit 1
    fi
done

# clone repo
git clone --recursive $github $repo

# move and link files
mkdir -p $bak_dir
for i in $(find $repo/conf -type f); do
    file=$(echo $i | rev | cut -d'/' -f1 | rev) # cut last field
    if [ -f ~/$file ]; then
        mv ~/$file $bak_dir
        ln -s $repo/conf/$file ~/$file
    fi
done

# spf13
(curl http://j.mp/spf13-vim3 -L) | sh

exit 0

