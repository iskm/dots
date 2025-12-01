#!/usr/bin/env bash
# Author: Ibrahim Mkusa
# Description: installs and sets up core environment for my dev work on servers

# constants
readonly ERROR_CODE=128

# current working directory
WORK_DIR=$(dirname "$(readlink -f "$0")")

usage() {
  cat <<EOF
$0 #installs and setups this environment
$0 undo  #removes all configs
$0 wipe #removes all configs and removes all installed packages
EOF
}

terminate() {
  echo -e "Terminating program"
  echo "${1}" >&2
  usage
  exit "${2:-128}"
}

header() {
  cat <<EOF
################################################################################
${1} | current directory: ${WORK_DIR}
################################################################################
EOF
}

if [[ $# -gt 1 ]]; then
  terminate "Too many variables" ${ERROR_CODE}
fi

# detect which family of distro i'm on
if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  header "Beginning installation script"
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
      #ansible="ansible-core"  # install via pip(x)
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
  exit ${ERROR_CODE}
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
header "Finished installation script"
