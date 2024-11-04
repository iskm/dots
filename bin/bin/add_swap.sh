#!/usr/bin/env bash
# Author Ibrahim Mkusa
# About  Creates or installs temporary swap space for machine

set -e

read -rp "Do you want to add or remove swapspace[add/remove]" response
if [[ "$response" == "add" ]]; then
        sudo mkdir -p /var/cache/swap
        sudo dd if=/dev/zero of=/var/cache/swap/swap0 bs=64M count=64
        sudo chmod 0600 /var/cache/swap/swap0
        sudo mkswap /var/cache/swap/swap0
        sudo swapon /var/cache/swap/swap0
        sudo swapon -s
elif [[ "$response" == "remove" ]]; then
        sudo swapoff /var/cache/swap/swap0
        sudo rm -rf /var/cache/swap/swap0
fi
