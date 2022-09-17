#!/bin/sh

# Set DNS to Google (in case stubby is missing)
uci delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server='8.8.8.8'
uci commit
/etc/init.d/dnsmasq restart

opkg update
opkg install keepalived uacme luci-app-ddns ddns-scripts dtc htop nano luci-proto-modemmanager 6in4 prometheus-node-exporter-lua prometheus-node-exporter-lua-netstat prometheus-node-exporter-lua-textfile prometheus-node-exporter-lua-openwrt
#opkg remove --force-depends tc-mod-iptables kmod-ipt-raw kmod-ipt-core kmod-ipt-ipopt kmod-ip6tables kmod-ipt-conntrack-extra kmod-ipt-raw kmod-ipt-conntrack  iptables-mod-conntrack-extra ip6tables-nft iptables-mod-ipopt kmod-ipt-ipset luci-app-sqm sqm-scripts

install_remote_ext() {
	wget "https://downloads.openwrt.org/releases/packages-22.03/aarch64_generic/$2/$1" -O "/tmp/$1"
	opkg install "/tmp/$1"
	rm -f "/tmp/$1"
}

install_remote() {
	install_remote_ext "$1" "packages"
}

install_remote "getdns_1.7.0-2_aarch64_generic.ipk"
install_remote "stubby_0.4.0-6_aarch64_generic.ipk"

/etc/init.d/prometheus-node-exporter-lua enable
/etc/init.d/prometheus-node-exporter-lua restart

/etc/init.d/keepalived enable
/etc/init.d/keepalived start

/etc/init.d/stubby enable
/etc/init.d/stubby start

# Set DNS back to stubby
uci delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server='127.0.0.1#5453'
uci commit
/etc/init.d/dnsmasq restart

mkdir -p /www/.well-known/acme-challenge

rm -f /etc/*/*-opkg
