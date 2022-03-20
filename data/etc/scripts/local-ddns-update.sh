#!/bin/sh

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
		uci commit
	fi

	i=$((i+1))
done
