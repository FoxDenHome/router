#!/bin/sh

# Set DNS to Google (in case stubby is missing)
uci delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server='8.8.8.8'
uci commit
/etc/init.d/dnsmasq restart

opkg update
opkg install mwan3 luci-app-mwan3 keepalived uacme luci-app-ddns ddns-scripts dtc htop nano luci-proto-modemmanager

install_remote() {
	wget "https://downloads.openwrt.org/releases/21.02.1/packages/aarch64_generic/packages/$1" -O "/tmp/$1"
	opkg install "/tmp/$1"
	rm -f "/tmp/$1"
}

install_remote "getdns_1.7.0-1_aarch64_generic.ipk"
install_remote "stubby_0.4.0-3_aarch64_generic.ipk"
install_remote "luasocket_2019-04-21-733af884-1_aarch64_generic.ipk"
install_remote "prometheus-node-exporter-lua_2022.04.18-1_all.ipk"
install_remote "prometheus-node-exporter-lua-netstat_2022.04.18-1_all.ipk"
install_remote "prometheus-node-exporter-lua-textfile_2022.04.18-1_all.ipk"
install_remote "prometheus-node-exporter-lua-openwrt_2022.04.18-1_all.ipk"

opkg install --force-reinstall /etc/scripts/dropbear_2020.81-2_aarch64_generic.ipk
rm -f /etc/dropbear/*-opkg /etc/config/dropbear-opkg
/etc/init.d/dropbear restart

/etc/init.d/prometheus-node-exporter-lua enable
/etc/init.d/prometheus-node-exporter-lua restart

/etc/init.d/mwan3 enable
/etc/init.d/mwan3 start

/etc/init.d/keepalived enable
/etc/init.d/keepalived start

/etc/init.d/stubby enable
/etc/init.d/stubby start

# Set DNS back to stubby
uci delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server='127.0.0.1#5453'
uci commit
/etc/init.d/dnsmasq restart

/etc/init.d/ipsec disable
/etc/init.d/ipsec stop

mkdir -p /www/.well-known/acme-challenge

rm -f /etc/*/*-opkg
