#!/usr/bin/env bash

# Author : Ibrahim Mkusa
# Description: installs and sets up core environment for my dev work on servers

set -e  # subshells inherit environment from parent

function usage() {
   echo "./install #installs and setups this environment"
   echo "./install undo  #removes all configs"
   echo "./install wipe #removes all configs and removes all installed packages"
}

# detect which family of distro i'm on
if [[ -f /etc/os-release ]]; then
  . /etc/os-release

  case "$ID_LIKE" in
    debian)
      echo "Running on debian-family.."
      package_manager=apt
      vim="vim-nox"
      ;;
    fedora)
      echo "Running on debian-family.."
      package_manager=fedora
      vim="vim-enhanced"
  esac
else
  echo "You are running an unrecognized family of os. Quitting..."
  exit 1
fi

# could have used a case, but i prefer the if statement
if [[ -z "$1" ]]; then
  echo "Installing packages"
  sudo "$package_manager" install -y "$vim" git stow curl ranger tmux

  # use gnu stow to symlink config files to home directory
  stow bash git ranger shellenv tmux vim

elif [[ undo = "$1" ]]; then
  echo "undoing"
  stow -D bash git ranger shellenv tmux vim

elif [[ wipe = "$1" ]]; then
  stow -D bash git ranger shellenv tmux vim
  sudo "$package_manager" remove "$vim" git stow curl ranger tmux
  echo "wiping"

elif [[ "$1" = "help" ]]; then
  usage
fi
  

