#!/bin/sh
set -eu

bak_dir=~/.dotfiles-bak
repo=~/.dotfiles
github=https://github.com/bob3000/dotfiles.git

# clone repo
git clone --recursive $github $repo

# move and link files
mkdir -p $bak_dir
for i in $(find $repo/conf -depth 1); do
    file=$(echo $i | rev | cut -d'/' -f1 | rev) # cut last field
    if [ -f ~/$file ] || [ -d ~/$file ]; then
        mv ~/$file $bak_dir
    fi
    ln -sf $repo/conf/$file ~/$file
done

mkdir ~/.vim
mkdir ~/.vimvar
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

exit 0

