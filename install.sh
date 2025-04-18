#!/usr/bin/env bash
# Author: Ibrahim Mkusa
# Description: installs and sets up core environment for my dev work on servers

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
      firewall="ufw"
      ;;
    fedora)
      echo "Running on rpm-family.."
      package_manager=dnf
      vim="vim-enhanced"
      ansible="ansible-core"
      firewall=""  #firewall & firewall-cmd installed by default on rpm OSes
      ;;
    *)
      echo "Running on best-guess"
      package_manager=apt
      vim="vim-nox"
      firewall="ufw"
      ;;
  esac
else
  echo "You are running an unrecognized family of os. Quitting..."
  exit 1
fi


# could have used a case, but i prefer the if statement
if [[ -z "$1" ]]; then
  echo "Installing packages"
  sudo "$package_manager" install -y "$vim" git stow curl ranger tmux \
    qemu-guest-agent $firewall cloud-init

  # firewall rules
  sudo $firewall allow ssh

  # install vim-plug
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # backup current configs
  [[ -f ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc.bak || echo "bashrc ~exists"
  [[ -f ~/.bash_profile ]] && mv ~/.bash_profile ~/.bash_profile.bak || echo ".bash_profile ~exists"

  # use gnu stow to symlink config files to home directory
  stow bash ranger shellenv tmux vim
  
  # install everything via plug "the vim package manager"
  vim +PlugInstall +qall
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
  
# extras for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
