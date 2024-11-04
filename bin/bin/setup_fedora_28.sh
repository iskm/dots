#!/usr/bin/env bash
#
# Author: Ibrahim Mkusa
# About: setup fedora 28

set -e 

read -p 'Rpmfusion installed?[y/n]' response
if [[ "$response" == "n" ]]; then
        exit
fi

sudo dnf upgrade -y

# install core programs
# python python3 zip unzip
sudo dnf install -y gcc gcc-c++ gparted git vim-enhanced keepassx \
 haskell-platform java-1.8.0-openjdk-devel maven  perl-core\
 rust cargo rustfmt kernel-devel\
 emacs rxvt-unicode-256color vlc qbittorrent udiskie \
 cmake xchm python-devel python3-devel\
 doxygen gnome-tweaks ack ctags zsh\
 lxappearance i3 i3lock feh \
 unclutter redshift-gtk polkit curl ShellCheck stow xclip ranger \
 scrot alsa-utils automake bash-completion bc bzip2 cppcheck pylint\
 dconf-editor mplayer smplayer cmus cava weechat \
 mpd mpc ncmpcpp\
 mutt notmuch-mutt arandr \
 pavucontrol  atool\
 virt-manager lynx ufw ddclient  x2goclient mosh\
 htop conky compton \
 golang the_silver_searcher\
 zathura zathura-plugins-all \
 ncdu gnome-shell-extension-pomodoro chrome-gnome-shell\
 caca-utils highlight atool w3m poppler-utils mediainfo\
 xbacklight tmux task\
 volumeicon tree blueman\
 direnv gimp clang clang-devel boost-devel\
 glances uuid screenfetch \
 nodejs npm nautilus-dropbox haskell-platform\
 texstudio octave gedit-plugins calibre\
 ruby ruby-devel multitail cowsay kodi fzf



echo -n "Install i3-gaps[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        sudo dnf copr enable gregw/i3desktop -y
        sudo dnf install -y i3-gaps rofi polybar
fi


echo -n "Install tlp stuff[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
	sudo dnf install -y tlp tlp-rdw
fi

echo -n "Install pia[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        chmod u+x ~/dotfiles/bin/bin/pia-nm.sh
        ~/dotfiles/bin/bin/pia-nm.sh
fi

echo -n "Install openssh server?[yes/no]"
read response
if [[ "$response" == "yes" ]]; then
        sudo dnf install -y openssh-server mosh
        sudo ufw allow 22 # allow ssh port 22
        sudo ufw allow 60000:61000/udp # allow mosh ports
        sudo ufw allow 60000/udp # allow only 60000
fi


cd ~
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier || true
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

# change shell
chsh -s /usr/bin/zsh

#sudo npm install -g typescript

# stow files
rm -rf ~/.bashrc ~/.bash_profile
cd ~/dotfiles
stow bash bin docs git i3 ranger shellenv ssh tmux vim\
        zsh 
cd -

vim +PlugInstall +qall

echo -n "Install steam[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        sudo dnf install -y steam
fi

echo -n "Setup tlp /etc/default/tlp"
echo -n "continue?[yes]"
read response

echo -n "Change gterminal's [1]menubar [2]fonts [3]colorscheme [4]settings scrollbar"
echo -n "Continue?[yes]"
read response

source ~/.bashrc
echo -n "Setup gtk-chtheme, gnome-tweak-tool, lxapperance, and qtconfig"
echo -n "Continue?[yes]"
read response

echo -n "Install shell extensions caffeine, dashtodock, pomodoro "
echo -n "openweather, refreshwificonns, removDrivMenu, soundinoutchoo "
echo -n "Continue?[yes]"
read response

echo -n "Setup ddclient only if on server"
echo -n "Continue?[yes]"
read response

echo -n "Log into dropbox, firefox sync, chrome sync, reddit, steam"
echo -n "Continue?[yes]"
read response

echo -n "Set desktop background"
echo -n "Continue?[yes]"
read response

echo -n "Portforward ssh 22, and for mosh udp 60000-60001"
echo -n "Continue?[yes]"
read response

echo -n "Install anaconda version 2.7, and a 3.5 env"
echo -n "packages rasterio tqdm opencv keras tensorflow fiona"
echo -n "Continue?[yes]"
read response
