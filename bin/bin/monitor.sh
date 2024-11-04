#!/usr/bin/env bash
# Author: Ibrahim Mkusa
# About: Places card into monitor mode and changes mac addresses
set -e

usage () {
  echo "monitor.sh [card] [up/down] [channel]"
}

if [[ "$2" == "up" ]];then
  # kill all interfering processes
  sudo airmon-ng check kill
   # start card in monitor mode optionally locked to channel
  sudo airmon-ng start "$1" "$3"
   # change mac address
  sudo ifconfig "$1mon" down
  sudo macchanger -A "$1mon"
  sudo ifconfig "$1mon" up
  iwconfig
  sudo macchanger --show "$1mon"

elif [[ "$2" == "down" ]];then
  sudo airmon-ng stop "$1"
  sudo systemctl restart NetworkManager.service || true
  sudo systemctl restart wpa_supplicant.service || true
  nmcli networking on || true
  iwconfig
else
  usage
fi



