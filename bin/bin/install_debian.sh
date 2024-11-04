#!/usr/bin/env bash
#
# Author: Ibrahim Mkusa
# About: uhhhhh installs a bunch of stuff i use(used) on a desktop

set -e 
cd ~  && echo "Changed directory $(whoami)'s home"

# Asks whether user is on an ubuntu or fedora distribution
read -rp "Are you on [ubuntu/fedora]" distro
if [[ "$distro" == "ubuntu" ]]; then
        manager="apt"
        vim="vim-nox"
        # install build essential libs
        sudo apt install -y build-essential cmake python3-dev
elif [[ "$distro" == "fedora" ]]; then
        manager="dnf"
        vim="vim-enhanced"
        sudo dnf install -y make automake gcc gcc-c++ kernel-devel \
                cmake python3-devel
else
        echo "No distro-specified. Exiting.. "
        exit 1
fi


# install core programs for use in both gnome or i3
sudo $manager install -y gparted git $vim keepassxc curl \
 default-jdk default-jre maven perl \
 emacs stterm vlc qbittorrent udiskie \
 cmake xchm python3 \
 doxygen gnome-tweaks ack zsh\
 lxappearance i3-wm i3lock feh \
 unclutter redshift-gtk shellcheck stow ranger \
 scrot alsa-utils automake bash-completion bc bzip2 cppcheck pylint \
 dconf-editor mplayer smplayer cmus weechat-curses \
 mpd mpc ncmpcpp\
 mutt notmuch-mutt arandr neomutt\
 pavucontrol  atool \
 virt-manager lynx ufw x2goclient mosh \
 htop conky-all compton \
 silversearcher-ag golang \
 zathura zathura-cb zathura-djvu zathura-ps \
 ncdu \
 caca-utils highlight w3m poppler-utils mediainfo \
 xbacklight tmux \
 volumeicon-alsa tree blueman \
 direnv gimp clang clang-tidy \
 glances uuid neofetch \
 nodejs npm \
 octave gedit-plugins calibre \
 ruby-full ruby-dev zlib1g-dev multitail cowsay \
 texstudio brightnessctl plocate postgresql texlive-latex-extra git-all\
 asciinema texlive-fonts-extra latexmk\
 texlive-lang-german znc \
 ecryptfs-utils rbenv python3-pip fd-find \
 vagrant rofi \
 libcdk5-dev libcdk5nc6 libcdk5-doc ripgrep \
 gnome-terminal polybar yacc \
 powertop gnome-browser-connector

#haskell-platform 

# snap stuff
# sudo snap install --beta nvim --classic

# better served by a case statement
if [[ "$distro" == "ubuntu" ]]; then
        sudo $manager install -y python3-dev exuberant-ctags \
                libclang-dev libboost-dev python3-venv libboost-all-dev \
                libnode-dev texlive-fonts-recommended
elif [[ "$distro" == "fedora" ]]; then
        sudo $manager install -y texlive-collection-fontsrecommended.noarch
fi


system="$(sudo dmidecode --string chassis-type)"
case $system in
        Notebook | Laptop)
                sudo $manager install -y tlp tlp-rdw
                ;;
esac

pia_url="https://installers.privateinternetaccess.com/download/pia-linux-3.3.1-06924.run"
read -rp "Install private internet access[yes/no]" response
if [[ "$response" == "yes" ]]; then
        wget --show-progress $pia_url
        chmod u+x "pia-linux-3.3.1-06924.run"
        ./pia-linux-3.3.1-06924.run
        rm -f pia-linux-3.3.1-06924.run
fi

read -rp "Install openssh server?[yes/no]" response
if [[ "$response" == "yes" ]]; then
        sudo $manager install -y openssh-server mosh ddclient
        sudo ufw allow 22 # allow ssh port 22
        sudo ufw allow 60000:61000/udp # allow mosh ports
        sudo ufw allow 60000/udp # allow only 60000
        
        # enable ufw
        sudo systemctl start ufw && sudo systemctl enable ufw
        sudo ufw enable
fi

read -p "Install Kernel dev tools?[yes/no]" response
if [[ "$response" == "yes" ]]; then
        sudo $manager install -y vim libncurses5-dev gcc make git exuberant-ctags \
                libssl-dev bison flex libelf-dev bc dwarves zstd git-email
fi


read -p "Install GTK+ tools?[yes/no]" response
if [[ "$response" == "yes" ]]; then
        sudo $manager install -y libgtk-4-1 libgtk-4-dev gtk-4-examples
fi


cd ~
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier || true
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
# prefix + capital I to install tmux plugins

# change shell
chsh -s /usr/bin/zsh

#sudo npm install -g typescript
#sudo snap install core; sudo snap refresh core
#read -p "Do you want to install certbot[yes/no]" response
#[[ "$response" == yes ]] && sudo snap install certbot
#sudo certbot renew --dry-run
# stow files
#rm -rf ~/.bashrc ~/.bash_profile
cd ~/dotfiles
stow bash bin docs git i3 ranger shellenv ssh tmux vim\
        zsh || true
# install fonts
cd fonts/powerline
chmod u+x install.sh # if not already
./install.sh
cd ~



#setup node version manager to track|install uptodate versions of node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# setup poetry python version manager
curl -sSL https://install.python-poetry.org | python3 -

# vim "best darn editor in the world""
vim +PlugInstall +qall

read -rp "Install steam[yes/no]" response
if [[ "$response" == "yes" ]]; then
        sudo $manager install -y steam
fi

# install pentest tools
read -rp "Install pentest tools[yes/no]" response
if [[ "$response" == "yes" ]]; then
        sudo $manager install -y nmap arp-scan steghide binwalk hcxtools \
                hashcat        
fi


#source "$HOME/.bashrc"
echo -n "Install anaconda version 2.7, and a 3.5 env"
echo -n "packages rasterio tqdm opencv keras tensorflow fiona"
echo -n "Continue?[yes]"
echo -n "gem install jekyll bundler"
