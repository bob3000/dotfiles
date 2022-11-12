#!/bin/bash
set -eux

function main() {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
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
      centos) echo 2 or 3
      ;;
      ubuntu|debian) echo default
        if [[ "$USER" == "linuxbrew" ]]; then
          xargs brew install < packages/pkglist.brew
        else
          apt
        fi
      ;;
    esac
  fi
}

main

