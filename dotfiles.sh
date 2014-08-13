#!/bin/sh
set -eu

bak_dir=~/.dotfiles-bak
repo=~/.dotfiles

# move and link files
mkdir -p $bak_dir
for i in $(find $repo/conf -type f -maxdepth 1); do
    file=$(echo $i | rev | cut -d'/' -f1 | rev) # cut last field
    if [ -f ~/$file ] || [ -d ~/$file ]; then
        mv ~/$file $bak_dir
    fi
    ln -sf $repo/conf/$file ~/$file
done
