#!/bin/bash
API_KEY="Td646dfc33353d56e5342W5657WWTX7f"
HOSTNAME="sshMaintainer.webredirect.org"

IP=$(curl -s https://api.ipify.org)

RESPONSE=$(curl -s "https://api.dynu.com/nic/update?hostname=$HOSTNAME&myip=$IP" \
    -H "API-Key: $API_KEY")
