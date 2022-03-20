#!/bin/sh

restart_wg() {
	ifconfig "$1" down
	ifconfig "$1" up
}

restart_wg VPN
restart_wg S2S
