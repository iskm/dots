#!/usr/bin/env bash

set -e

sudo dnf install -y syncthing git-core vim-enhanced keepassxc stow container-tools

sudo dnf group install "Virtualization Host"

# setup syncthing
sudo systemctl start syncthing@$USER
sudo systemctl enable syncthing@$USER
