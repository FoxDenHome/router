#!/bin/sh
set -e

IPS="8.8.8.8 208.67.222.222 8.8.4.4 208.67.220.220"

SWITCH_TO_DEFAULT_PERCENT=80
SWITCH_TO_FAILOVER_PERCENT=1

DEFAULT_NETWORK="WAN"
DEFAULT_DEVICE="$(uci get network.WAN.device)"

FAILOVER_METRIC_NORMAL=100
FAILOVER_METRIC_ACTIVE=10
FAILOVER_NETWORK="LTE"
FAILOVER_DEVICE="wwan0"

ping_check() {
	local IFACE="$1"
	local IP="$2"
	local COUNT=2
	local MIN_SUCCESS_COUNT=2

	local RESULT="$(ping -c "$COUNT" -W 1 -I "$IFACE" "$IP" -q)"
	#PING 8.8.8.8 (8.8.8.8): 56 data bytes
	#
	#--- 8.8.8.8 ping statistics ---
	#5 packets transmitted, 5 packets received, 0% packet loss
	#round-trip min/avg/max = 1.674/1.734/1.827 ms
	
	local SUCCESS_COUNT="$(echo $RESULT | grep -o -a -m 1 '\d* packets received' | cut -d' ' -f1)"

	if [ $SUCCESS_COUNT -lt $MIN_SUCCESS_COUNT ]
	then
		logger -p warn -t wan-check "Could not reach $IP on $IFACE"
		echo FAIL
	else
		echo OK
	fi
}

multi_ping() {
	local IFACE="$1"

	local TOTAL_COUNT=0
	local OK_COUNT=0
	for IP in $IPS
	do
		TOTAL_COUNT=$(expr $TOTAL_COUNT '+' 1)
		if [ "$(ping_check "$IFACE" "$IP")" == "OK" ]
		then
			OK_COUNT=$(expr $OK_COUNT '+' 1)
		fi
	done

	expr $OK_COUNT '*' 100 '/' $TOTAL_COUNT
}

set_metric() {
	local NETWORK="$1"
	local METRIC="$2"

	local CONFIG_KEY="network.$NETWORK.metric"

	local CURRENT_METRIC="$(uci get "$CONFIG_KEY")"
	
	if [ $CURRENT_METRIC -ne $METRIC ]
	then
		echo uci set "$CONFIG_KEY=$METRIC"
		echo uci commit
		echo /etc/init.d/network reload
	fi
}

PERCENT_OK="$(multi_ping "$DEFAULT_DEVICE")"

if [ $PERCENT_OK -ge $SWITCH_TO_DEFAULT_PERCENT ]
then
	set_metric "$FAILOVER_NETWORK" "$FAILOVER_METRIC_NORMAL"
elif [ $PERCENT_OK -le $SWITCH_TO_FAILOVER_PERCENT ]
then
	set_metric "$FAILOVER_NETWORK" "$FAILOVER_METRIC_ACTIVE"
fi
