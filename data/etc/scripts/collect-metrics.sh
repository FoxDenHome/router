#!/bin/sh
mkdir -p /var/prometheus

TEST_IP="8.8.8.8"
INTERFACES="eth5:wired:1 wwan0:lte:2"

ROUTE="$(ip route get "$TEST_IP" | head -1 | grep -o "dev \\w*")"
ROUTE_ECHOED="$(mktemp -u)"

echoroute() {
	IDX="$1"
	if [ ! -e "$ROUTE_ECHOED" ]
	then
		echo "active_route_index{target=\"$TEST_IP\"} $IDX"
		touch "$ROUTE_ECHOED"
	fi
}

pingtest() {
	RAW_IFACE="$1"
	NAME="$2"
	IDX="$3"
	IFACE="$RAW_IFACE"
	if [ ! -z "$IFACE" ]
	then
		IFACE="-I$IFACE"
	fi

	ping $IFACE -c 1 "$TEST_IP" >/dev/null
	RES="$(ping $IFACE -c 3 "$TEST_IP")"
	CODE="$?"

	LOSS="$(echo -n "$RES" | grep -F 'packet loss'  | tail -1 | cut -d, -f3 | cut -d% -f1 | tr -d ' ')"
	AVG="$(echo -n "$RES" | grep -F 'round-trip' | tail -1 | cut -d/ -f4)"

	if [ -z "$LOSS" ]
	then
		LOSS=100
	fi

	echo "ping_response_code{device=\"$RAW_IFACE\",name=\"$NAME\",target=\"$TEST_IP\"} $CODE"
	echo "ping_percent_packet_loss{device=\"$RAW_IFACE\",name=\"$NAME\",target=\"$TEST_IP\"} $LOSS"
	if [ ! -z "$AVG" ]
	then
		echo "ping_average_response_ms{device=\"$RAW_IFACE\",name=\"$NAME\",target=\"$TEST_IP\"} $AVG"

		if [ "$ROUTE" == "dev $RAW_IFACE" ]
		then
			echoroute "$IDX"
		fi
	fi
}

# modem.signal.lte.rssi     : -65.00
# modem.signal.lte.rsrq     : -17.00
# modem.signal.lte.rsrp     : -103.00
# modem.signal.lte.snr      : -1.00

kvextract() {
	KEY="$1"
	echo -n "$2" | grep "^$KEY" | cut -d: -f2 | tr -d ' \r\t'
}

ltetest() {
	IFACE="$1"
	NAME="$2"

	RES_MAIN="$(mmcli -m "$IFACE" -K)"
	RES="$(mmcli -m "$IFACE" --signal-get -K)"

	IFACE_NAME="$(kvextract 'modem\.generic\.ports\.value' "$RES_MAIN" | grep '(net)$' | head -1 | cut '-d(' -f1)"

	echo "modem_signal_lte_rssi{device=\"$IFACE_NAME\",name=\"$NAME\"} $(kvextract 'modem\.signal\.lte\.rssi ' "$RES")"
	echo "modem_signal_lte_rsrq{device=\"$IFACE_NAME\",name=\"$NAME\"} $(kvextract 'modem\.signal\.lte\.rsrq ' "$RES")"
	echo "modem_signal_lte_rsrp{device=\"$IFACE_NAME\",name=\"$NAME\"} $(kvextract 'modem\.signal\.lte\.rsrp ' "$RES")"
	echo "modem_signal_lte_snr{device=\"$IFACE_NAME\",name=\"$NAME\"} $(kvextract 'modem\.signal\.lte\.snr ' "$RES")"
}

first_modem() {
	RES="$(mmcli --list-modems -K)"
	MODEM_PATH="$(kvextract 'modem-list\.value\[1\]' "$RES" | head -1)"
	echo "$MODEM_PATH"
}

echo_gauge() {
	NAME="$1"
	HELP="$2"
	echo "# HELP $NAME $HELP"
	echo "# TYPE $NAME gauge"
}

MODEM_PATH="$(first_modem)"

(
	echo_gauge 'ping_response_code' 'Response code of ping command'
	echo_gauge 'ping_percent_packet_loss' 'Packet loss in percent (0-100)'
	echo_gauge 'ping_average_response_ms' 'Round trip time in fractional milliseconds'

	echo_gauge 'modem_signal_lte_rssi' 'LTE signal RSSI'
	echo_gauge 'modem_signal_lte_rsrq' 'LTE signal RSRQ'
	echo_gauge 'modem_signal_lte_rsrp' 'LTE signal RSRP'
	echo_gauge 'modem_signal_lte_snr' 'LTE signal SNR'

	pingtest '' 'internet' &
	for IFACE in $INTERFACES
	do
		pingtest $(echo -n "$IFACE" | sed 's/:/ /g') &
	done
	ltetest "$MODEM_PATH" 'lte' &

	wait

	if [ ! -z "$ROUTE" ]
	then
		echoroute 9999
	else
		echoroute 0
	fi
) > /var/prometheus/custommetrics.tmp

rm -f "$ROUTE_ECHOED"

rm -f /var/prometheus/custommetrics.prom
mv /var/prometheus/custommetrics.tmp /var/prometheus/custommetrics.prom
