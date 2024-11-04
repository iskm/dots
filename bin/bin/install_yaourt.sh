#!/bin/bash
#
set -e           #subshell, so it doesn't mess with my current shell

cd ~
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
