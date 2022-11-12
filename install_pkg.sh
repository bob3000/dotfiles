#!/bin/bash
set -eux

function main() {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    brew update
    xargs brew install < packages/pkglist.brew
    exit 0
  fi

  if [[ "$OSTYPE" =~ ^linux ]]; then
    DIST="$(awk -F'=' '/^ID=/{print $2}' /etc/os-release)"
    case "$DIST" in
      arch)
        pacman -Sy
        pacman -S --noconfirm --needed - < packages/pkglist.pacman
      ;;
      centos)
        echo "not implemented"
      ;;
      ubuntu|debian) echo default
        apt-get update
        xargs apt-get install -y < packages/pkglist.apt
      ;;
    esac
  fi
}

main

