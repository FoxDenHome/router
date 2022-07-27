#!/bin/sh

if [ -z "$__IP" ]
then
	echo "Missing __IP env"
	exit 1
fi

i=0
while :
do
	RES="$(uci show "dhcp.@domain[$i]")"
	if [ -z "$RES" ]
	then
		break
	fi

	if echo "$RES" | grep -qF ".name='vpn'"
	then
		uci set "dhcp.@domain[$i].ip=$__IP"
	fi

	i=$((i+1))
done

uci commit
/etc/init.d/dnsmasq restart
