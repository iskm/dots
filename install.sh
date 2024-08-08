#!/usr/bin/env bash

# Author : Ibrahim Mkusa
# Description: installs and sets up core environment for my dev work on servers

set -e  # subshells inherit environment from parent

# detect which family of distro i'm on
if [[ -f /etc/os-release ]]; then
  . /etc/os-release

  case "$ID_LIKE" in
    debian)
      echo "Running on debian-family. Installing core packages"
      package_manager=apt
      sudo $package_manager install -y vim-nox git stow curl ranger tmux
      ;;
    fedora)
      echo "Running on debian-family. Installing core packages"
      package_manager=fedora
      sudo $package_manager install -y vim-enhanced git stow curl ranger tmux
  esac
else
  echo "You are running an unrecognized family of os. Quitting..."
  exit 1
fi

# use gnu stow to symlink config files to home directory
stow bash git ranger shellenv tmux vim
