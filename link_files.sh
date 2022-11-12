#!/bin/bash
set -eux

function link_common_files() {
  mkdir -p ${HOME}/.config/kitty
  mkdir -p ${HOME}/.config/lvim
  mkdir -p ${HOME}/.zshrc.local.d
  touch ${HOME}/.zshrc.local.d/.keep
  ln -s "$PWD/conf/.gitconfig" ${HOME}/.gitconfig
  ln -s "$PWD/conf/.pythonstartup" ${HOME}/.pythonstartup
  ln -s "$PWD/conf/.tmux.conf" ${HOME}/.tmux.conf
  ln -s "$PWD/conf/kitty.conf" ${HOME}/.config/kitty/kitty.conf
  ln -s "$PWD/conf/starship.toml" ${HOME}/.config/starship.toml
  ln -s "$PWD/conf/lv-config.lua" ${HOME}/.config/lvim/config.lua
  ln -s "$PWD/conf/.zshrc" ${HOME}/.zshrc
}

function link_mac_files() {
  ln -s "$PWD/conf/.zshrc.mac" "${HOME}/.zshrc.mac"
}

function link_linux_files() {
  ln -s "$PWD/conf/.zshrc.linux" "${HOME}/.zshrc.linux"
}

function main() {
  link_common_files
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    # TODO: brew install
    link_mac_files
  fi

  if [[ "$OSTYPE" =~ ^linux ]]; then
    link_linux_files
  fi
}

main
