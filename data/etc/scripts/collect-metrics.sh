#!/bin/sh
mkdir -p /var/prometheus

TEST_IP="8.8.8.8"
INTERFACES="eth5:wired wwan0:lte"

pingtest() {
	RAW_IFACE="$1"
	NAME="$2"
	IFACE="$RAW_IFACE"
	if [ ! -z "$IFACE" ]
	then
		IFACE="-I$IFACE"
	fi

	RES="$(ping $IFACE -c 2 "$TEST_IP")"
	CODE="$?"

	LOSS="$(echo -n "$RES" | grep -F 'packet loss'  | tail -1 | cut -d, -f3 | cut -d% -f1 | tr -d ' ')"
	AVG="$(echo -n "$RES" | grep -F 'round-trip' | tail -1 | cut -d/ -f4)"

	if [ -z "$LOSS" ]
	then
		LOSS=100
	fi

	echo "ping_response_code{interface=\"$RAW_IFACE\",name=\"$NAME\",target=\"$TEST_IP\"} $CODE"
	echo "ping_percent_packet_loss{interface=\"$RAW_IFACE\",name=\"$NAME\",target=\"$TEST_IP\"} $LOSS"
	if [ ! -z "$AVG" ]
	then
		echo "ping_average_response_ms{interface=\"$RAW_IFACE\",name=\"$NAME\",target=\"$TEST_IP\"} $AVG"
	fi
}

# modem.signal.lte.rssi     : -65.00
# modem.signal.lte.rsrq     : -17.00
# modem.signal.lte.rsrp     : -103.00
# modem.signal.lte.snr      : -1.00

kvextract() {
	KEY="$1"
	echo -n "$2" | grep "^$KEY " | cut -d: -f2 | tr -d ' \r\n\t'
}

ltetest() {
	IFACE="$1"
	NAME="$2"

	RES="$(mmcli -m "$IFACE" --signal-get -K)"

	echo "modem_signal_lte_rssi{interface=\"$IFACE\",name=\"$NAME\"} $(kvextract 'modem.signal.lte.rssi' "$RES")"
	echo "modem_signal_lte_rsrq{interface=\"$IFACE\",name=\"$NAME\"} $(kvextract 'modem.signal.lte.rsrq' "$RES")"
	echo "modem_signal_lte_rsrp{interface=\"$IFACE\",name=\"$NAME\"} $(kvextract 'modem.signal.lte.rsrp' "$RES")"
	echo "modem_signal_lte_snr{interface=\"$IFACE\",name=\"$NAME\"} $(kvextract 'modem.signal.lte.snr' "$RES")"
}

echo_gauge() {
	NAME="$1"
	HELP="$2"
	echo "# HELP $NAME $HELP"
	echo "# TYPE $NAME gauge"
}

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
	ltetest '0' 'lte' &

	wait
) > /var/prometheus/custommetrics.tmp

rm -f /var/prometheus/custommetrics.prom
mv /var/prometheus/custommetrics.tmp /var/prometheus/custommetrics.prom
