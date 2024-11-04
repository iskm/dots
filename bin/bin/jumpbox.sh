#!/bin/bash
# add the following to a lingering users crontab 
# Creates reverse ssh connection on public server
# Makes services running on server available locally (TheLounge)
# Kinda redundant nowadays due to tails, openvpn. You never know tho
# PS: the usernames and hosts don't actually exist :)
ssh -fN -R "3022:localhost:22" kijana@kwendasalama.org
ssh -fN -R "4022:localhost:22" mzee@kwendasalama.org
ssh -L "127.0.0.1:9000:127.0.0.1:9000" kijana@kwendasalama.org
echo "reverse ports created $(date)" >> error.log
