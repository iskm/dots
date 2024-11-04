#!/usr/bin/env bash
#
# Author: Ibrahim Mkusa
# About: setup archlinux
set -e

chmod u+x ~/dotfiles/bin/bin/install_yaourt.sh
~/dotfiles/bin/bin/install_yaourt.sh

sudo yaourt -S --needed --noconfirm gvim emacs geany atom\
        libreoffice-fresh\
        the_silver_searcher ripgrep \
        mpv mpd cmus ncmpcpp vlc pianobar rhythmbox audacity mplayer smplayer\
        zsh fish\
        ranger tree rsync lftp udiskie ncdu os-prober veracrypt\
        zathura zathura-cb zathura-djvu zathura-pdf-poppler zathura-ps\
        calibre vimpager freemind labyrinth xournal\
        firefox youtube-dl wireshark-gtk wget curl nmap httpie thefuck\
        elinks links lynx w3m\
        gcc go go-tools lua ruby ruby-docs valgrind gdb make cmake\
        htop glances polkit unclutter conky conky-manager cronie\
        pavucontrol\
        screenfetch dmidecode hwdetect hwinfo\
        python python2 python2-requests python-pip python2-pip\
        git tig\
        weechat irssi hexchat bitlbee pidgin newsbeuter\
        asciidoc markdown pandoc python-sphinx\
        tmux 
        qbittorrent rtorrent transmission-gtk transmission-cli\
        aria2\
        zip unzip\
        tlp tlp-rdw\
        xchm \
        keepassx2\
        ack\
        imagemagick gimp inkscape\
        autocutsel\
        ctags \
        shellcheck\
        rxvt-unicode\
        mutt notmuch notmuch-vim notmuch-mutt thunderbird\
        xclip\
        hamster-time-tracker task units arduino\
        scrot\
        alsa-utils\
        bash-completion\
        racket\
        xorg-server xorg-apps xorg-xinit xorg-xclock\
        xorg-xbacklight arandr\
        xf86-video-intel\
        rofi feh sxiv dmenu compton dunst volumeicon ntfs-3g redshift xautolock\
        xmonad xmonad-contrib xmobar xterm stalonetray xcompmgr\
        recordmydesktop gtk-recordmydesktop\
        docker\
        networkmanager network-manager-applet networkmanager-openvpn\
        gnome gnome-extra gthumb nautilus-open-terminal gedit-plugins\
        gparted lxappearance numix-gtk-theme arc-gtk-theme arc-icon-theme\
        ghc cabal-install haskell-haddock-api haskell-haddock-library happy alex\
        alsa-utils pulseaudio xf86-input-synaptics\
        texlive-core texlive-fontsextra texlive-latexextra texstudio steam\
        adobe-source-code-pro-fonts adobe-source-sans-pro-fonts\
        adobe-source-serif-pro-fonts\
        virtualbox linux-lts-headers virtualbox-guest-iso\
        lxde virt-manager direnv boost rust octave doxygen x2goclient

# setup ssh
echo -n "Install openssh server?[yes/no]"
read response
if [[ "$response" == "yes" ]]; then
        yaourt -S openssh ddclient sshfs mosh fail2ban ufw x2goserver
        # server setup
        sudo systemctl enable sshd.service
        sudo systemctl enable ddclient.service
        # server stuff
        sudo ufw allow 22 # allow ssh port 22
        sudo ufw allow 60000:61000/udp # allow mosh ports
        sudo ufw allow 60000/udp # allow only 60000
        # start x2go
        x2godbadmin --createdb
        sudo systemctl enable x2goserver.service
fi

# virtualbox virtualbox-ext-pack 

cd ~
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier || true
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

# stow files
rm -rf ~/.bashrc
cd ~/dotfiles
stow bash bin docs git i3 newsbeuter ranger shellenv ssh tmux vim\
        zsh 
cd -

vim


echo -n "Install i3-gaps[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        yaourt -S i3-gaps polybar 
fi

echo -n "Install xfce stuff[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        yaourt -S xfce4 xfce4-goodies 
fi

echo -n "Install nodejs[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        yaourt -S nodejs npm
        yaourt -S nvm 
fi

echo -n "Install cuda[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        # /opt/cuda/{bin, samples, doc}
        yaourt -S --noconfirm nvidia-lts nvidia-settings cuda cudnn freeglut
fi

echo -n "Install Google chrome[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        yaourt -S --noconfirm google-chrome 
fi

yaourt -S --needed dropbox

## install the stable lts kernel
yaourt -S linux-lts
# remove the standard linux kernel
yaourt -R linux
# should be populated with the -lts kernel
ls -lsha /boot
# back up old grub.cfg
sudo os-prober 
sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak
# generate new grub.cfg
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo systemctl enable gdm.service
sudo systemctl enable cronie.service
chmod u+x ~/dotfiles/bin/bin/setup_networkmanager.sh
~/dotfiles/bin/bin/setup_networkmanager.sh
#./pia-nm.sh

echo -n "Setup tlp /etc/default/tlp"
echo -n "continue?[yes]"
read response

echo -n "Change gterminal's [1]menubar [2]fonts [3]colorscheme [4]settings"
echo -n "Continue?[yes]"
read response

source ~/.bashrc
echo -n "Setup gtk-chtheme, gnome-tweak-tool, lxapperance, and qtconfig"
echo -n "Continue?[yes]"
read response

echo -n "Install shell extensions from box/internet/gnomeshellextensions list"
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
chsh -s /usr/bin/zsh
# pip stuff

# after enabling multilib
sudo vim /etc/pacman.conf
yaourt -Syu

echo -n "Install steam[yes/no]?"
read -r response
if [[ "$response" == "yes" ]]; then
        yaourt -S steam
fi
# Nvidia drivers are pain. I only buy amdgpus
#yaourt -Syu && yaourt -S steam lib32-nvidia-utils
#yaourt -S --needed wine winetricks mono lib32-alsa-lib lib32-alsa-plugins lib32-libxml2\
  #lib32-mpg123 lib32-lcms2 lib32-giflib lib32-libpng lib32-gnutls\
  #lib32-libpulse
