#!/bin/bash
set -eux

function backup_and_link() {
  src=$1
  dest=$2
  if [ -L "$dest" ]; then
    return
  fi

  if [ -f "$dest" ]; then
    mv "$dest" "${dest}.bak"
  fi
  mkdir -p "$(dirname $dest)"
  ln -s "$src" "$dest"
}

function link_common_files() {
  backup_and_link "$PWD/conf/.gitconfig" "${HOME}/.gitconfig"
  backup_and_link "$PWD/conf/.pythonstartup" "${HOME}/.pythonstartup"
  backup_and_link "$PWD/conf/.tmux.conf" "${HOME}/.tmux.conf"
  backup_and_link "$PWD/conf/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
  backup_and_link "$PWD/conf/starship.toml" "${HOME}/.config/starship.toml"
  backup_and_link "$PWD/conf/lv-config.lua" "${HOME}/.config/lvim/config.lua"
  backup_and_link "$PWD/conf/.zshrc" "${HOME}/.zshrc"
  backup_and_link "$PWD/conf/config.fish" "${HOME}/.config/fish/config.fish"
  backup_and_link "$PWD/conf/.tmux/tmuxline" "${HOME}/.tmux/tmuxline"
  backup_and_link "$PWD/conf/.tmux/scripts" "${HOME}/.tmux/scripts"
  backup_and_link "$PWD/conf/starship.toml" "${HOME}/.config/starship.toml"
}

function link_mac_files() {
  backup_and_link "$PWD/conf/.zshrc.mac" "${HOME}/.zshrc.mac"
}

function link_linux_files() {
  backup_and_link "$PWD/conf/.zshrc.linux" "${HOME}/.zshrc.linux"
}

function main() {
  link_common_files
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    link_mac_files
  fi

  if [[ "$OSTYPE" =~ ^linux ]]; then
    link_linux_files
  fi
}

main
