#!/bin/sh
set -e

. /lib/functions.sh
. /lib/functions/network.sh

network_get_ipaddr ipaddr WAN

echo "WAN IP = $ipaddr"
wget -qO- "http://10.99.10.1:9999/update-ip?ip=$ipaddr"
