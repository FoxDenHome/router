# ____-__-__ __:__:__ by RouterOS 7.18
# software id = REMOVED
#
# model = RB5009UG+S+
# serial number = REMOVED
/container mounts add dst=/config name=snirouter-config src=/snirouter
/container mounts add dst=/config name=foxdns-config src=/foxdns
/container mounts add dst=/config name=foxdns-internal-config src=/foxdns-internal
/disk add slot=tmpfs-scratch tmpfs-max-size=16000000 type=tmpfs
/interface ethernet set [ find default-name=ether2 ] disabled=yes name=eth2 rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether3 ] disabled=yes name=eth3 rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether4 ] disabled=yes name=eth4 rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether5 ] disabled=yes name=eth5 rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether6 ] disabled=yes name=eth6 rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether7 ] disabled=yes name=eth7 rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether8 ] comment=eth8 name=oob rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=sfp-sfpplus1 ] comment=sfp1 l2mtu=9092 mtu=9000 name=vlan-mgmt rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=ether1 ] advertise=1G-baseT-full,2.5G-baseT comment=eth1 name=wan rx-flow-control=on tx-flow-control=on
/interface gre add name=gre-tunnel1 remote-address=0.0.0.0
/interface 6to4 add !keepalive mtu=1480 name=6to4-redfox remote-address=144.202.81.146
/interface wireguard add listen-port=13232 mtu=1420 name=wg-s2s
/interface wireguard add listen-port=13231 mtu=1420 name=wg-vpn
/interface veth add address=172.17.1.2/24 gateway=172.17.1.1 gateway6="" name=veth-foxdns
/interface veth add address=172.17.2.2/24 gateway=172.17.2.1 gateway6="" name=veth-foxdns-internal
/interface veth add address=172.17.0.2/24 gateway=172.17.0.1 gateway6="" name=veth-snirouter
/interface vrrp add group-authority=self interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-dns priority=25 version=2 vrid=53
/interface vrrp add group-authority=self interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-gateway priority=25 version=2
/interface vrrp add group-authority=self interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-gateway6 priority=25 v3-protocol=ipv6 vrid=2
/interface vrrp add group-authority=self interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-ntp priority=25 version=2 vrid=123
/interface vlan add interface=vlan-mgmt mtu=9000 name=vlan-dmz vlan-id=3
/interface vlan add interface=vlan-mgmt mtu=9000 name=vlan-hypervisor vlan-id=6
/interface vlan add interface=vlan-mgmt mtu=9000 name=vlan-labnet vlan-id=4
/interface vlan add interface=vlan-mgmt mtu=9000 name=vlan-lan vlan-id=2
/interface vlan add interface=vlan-mgmt name=vlan-retro vlan-id=7
/interface vlan add interface=vlan-mgmt mtu=9000 name=vlan-security vlan-id=5
/interface vrrp add group-authority=vrrp-mgmt-dns interface=vlan-dmz mtu=9000 name=vrrp-dmz-dns priority=25 version=2 vrid=53
/interface vrrp add group-authority=vrrp-mgmt-gateway interface=vlan-dmz mtu=9000 name=vrrp-dmz-gateway priority=25 version=2
/interface vrrp add group-authority=vrrp-mgmt-gateway6 interface=vlan-dmz mtu=9000 name=vrrp-dmz-gateway6 priority=25 v3-protocol=ipv6 vrid=2
/interface vrrp add group-authority=vrrp-mgmt-ntp interface=vlan-dmz mtu=9000 name=vrrp-dmz-ntp priority=25 version=2 vrid=123
/interface vrrp add group-authority=vrrp-mgmt-dns interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-dns priority=25 version=2 vrid=53
/interface vrrp add group-authority=vrrp-mgmt-gateway interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-gateway priority=25 version=2
/interface vrrp add group-authority=vrrp-mgmt-gateway6 interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-gateway6 priority=25 v3-protocol=ipv6 vrid=2
/interface vrrp add group-authority=vrrp-mgmt-ntp interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-ntp priority=25 version=2 vrid=123
/interface vrrp add group-authority=vrrp-mgmt-dns interface=vlan-labnet mtu=9000 name=vrrp-labnet-dns priority=25 version=2 vrid=53
/interface vrrp add group-authority=vrrp-mgmt-gateway interface=vlan-labnet mtu=9000 name=vrrp-labnet-gateway priority=25 version=2
/interface vrrp add group-authority=vrrp-mgmt-gateway6 interface=vlan-labnet mtu=9000 name=vrrp-labnet-gateway6 priority=25 v3-protocol=ipv6 vrid=2
/interface vrrp add group-authority=vrrp-mgmt-ntp interface=vlan-labnet mtu=9000 name=vrrp-labnet-ntp priority=25 version=2 vrid=123
/interface vrrp add group-authority=vrrp-mgmt-dns interface=vlan-lan mtu=9000 name=vrrp-lan-dns priority=25 version=2 vrid=53
/interface vrrp add group-authority=vrrp-mgmt-gateway interface=vlan-lan mtu=9000 name=vrrp-lan-gateway priority=25 version=2
/interface vrrp add group-authority=vrrp-mgmt-gateway6 interface=vlan-lan mtu=9000 name=vrrp-lan-gateway6 priority=25 v3-protocol=ipv6 vrid=2
/interface vrrp add group-authority=vrrp-mgmt-ntp interface=vlan-lan mtu=9000 name=vrrp-lan-ntp priority=25 version=2 vrid=123
/interface vrrp add group-authority=vrrp-mgmt-dns interface=vlan-security mtu=9000 name=vrrp-security-dns priority=25 version=2 vrid=53
/interface vrrp add group-authority=vrrp-mgmt-gateway interface=vlan-security mtu=9000 name=vrrp-security-gateway priority=25 version=2
/interface vrrp add group-authority=vrrp-mgmt-gateway6 interface=vlan-security mtu=9000 name=vrrp-security-gateway6 priority=25 v3-protocol=ipv6 vrid=2
/interface vrrp add group-authority=vrrp-mgmt-ntp interface=vlan-security mtu=9000 name=vrrp-security-ntp priority=25 version=2 vrid=123
/interface list add name=iface-mgmt
/interface list add name=iface-lan
/interface list add name=iface-dmz
/interface list add name=iface-labnet
/interface list add name=iface-security
/interface list add name=iface-hypervisor
/interface list add include=iface-dmz,iface-hypervisor,iface-labnet,iface-lan,iface-mgmt,iface-security name=zone-local
/interface list add name=zone-wan
/iot lora servers add address=eu.mikrotik.thethings.industries name=TTN-EU protocol=UDP
/iot lora servers add address=us.mikrotik.thethings.industries name=TTN-US protocol=UDP
/iot lora servers add address=eu1.cloud.thethings.industries name="TTS Cloud (eu1)" protocol=UDP
/iot lora servers add address=nam1.cloud.thethings.industries name="TTS Cloud (nam1)" protocol=UDP
/iot lora servers add address=au1.cloud.thethings.industries name="TTS Cloud (au1)" protocol=UDP
/iot lora servers add address=eu1.cloud.thethings.network name="TTN V3 (eu1)" protocol=UDP
/iot lora servers add address=nam1.cloud.thethings.network name="TTN V3 (nam1)" protocol=UDP
/iot lora servers add address=au1.cloud.thethings.network name="TTN V3 (au1)" protocol=UDP
/ip dhcp-server add interface=vlan-retro lease-time=1h name=dhcp-retro
/ip dhcp-server option add code=121 name=classless value="'16''10''3'\$(NETWORK_GATEWAY)'0'\$(NETWORK_GATEWAY)"
/ip dhcp-server option sets add name=default-classless options=classless
/ip pool add name=pool-mgmt ranges=10.1.150.0-10.1.199.255
/ip pool add name=pool-lan ranges=10.2.150.0-10.2.199.255
/ip pool add name=pool-dmz ranges=10.3.150.0-10.3.199.255
/ip pool add name=pool-labnet ranges=10.4.150.0-10.4.199.255
/ip pool add name=pool-security ranges=10.5.150.0-10.5.199.255
/ip pool add name=pool-hypervisor ranges=10.6.150.0-10.6.199.255
/ip pool add name=pool-oob ranges=192.168.88.100-192.168.88.200
/ip dhcp-server add address-pool=pool-labnet authoritative=after-2sec-delay dhcp-option-set=default-classless interface=vlan-labnet lease-time=1h name=dhcp-labnet
/ip dhcp-server add address-pool=pool-lan authoritative=after-2sec-delay dhcp-option-set=default-classless interface=vlan-lan lease-time=1h name=dhcp-lan
/ip dhcp-server add address-pool=pool-dmz authoritative=after-2sec-delay dhcp-option-set=default-classless interface=vlan-dmz lease-time=1h name=dhcp-dmz
/ip dhcp-server add address-pool=pool-mgmt authoritative=after-2sec-delay dhcp-option-set=default-classless interface=vlan-mgmt lease-time=1h name=dhcp-mgmt
/ip dhcp-server add address-pool=pool-security authoritative=after-2sec-delay dhcp-option-set=default-classless interface=vlan-security lease-time=1h name=dhcp-security
/ip dhcp-server add address-pool=pool-hypervisor authoritative=after-2sec-delay dhcp-option-set=default-classless interface=vlan-hypervisor lease-time=1h name=dhcp-hypervisor
/ip dhcp-server add address-pool=pool-oob bootp-support=none interface=oob lease-time=1h name=dhcp-oob
/ip smb users set [ find default=yes ] disabled=yes
/port set 0 baud-rate=115200
/routing bgp template set default disabled=yes routing-table=main
/snmp community set [ find default=yes ] disabled=yes
/snmp community add addresses=::/0 name=monitor_REMOVED
/user group add name=monitoring policy=read,api,!local,!telnet,!ssh,!ftp,!reboot,!write,!policy,!test,!winbox,!password,!web,!sniff,!sensitive,!romon,!rest-api
/user group add name=nologin
/container add interface=veth-snirouter logging=yes mounts=snirouter-config start-on-boot=yes workdir=/
/container add interface=veth-foxdns logging=yes mounts=foxdns-config start-on-boot=yes workdir=/config
/container add interface=veth-foxdns-internal logging=yes mounts=foxdns-internal-config start-on-boot=yes workdir=/config
/container config set registry-url=https://ghcr.io
/ip firewall connection tracking set loose-tcp-tracking=no
/ip settings set rp-filter=loose tcp-syncookies=yes
/ipv6 settings set accept-redirects=no accept-router-advertisements=no
/interface list member add interface=vlan-lan list=iface-lan
/interface list member add interface=vlan-dmz list=iface-dmz
/interface list member add interface=vlan-labnet list=iface-labnet
/interface list member add interface=vlan-security list=iface-security
/interface list member add interface=vlan-hypervisor list=iface-hypervisor
/interface list member add interface=wan list=zone-wan
/interface list member add interface=vlan-mgmt list=iface-mgmt
/interface list member add interface=wg-s2s list=zone-local
/interface list member add interface=wg-vpn list=zone-local
/interface list member add interface=vrrp-mgmt-gateway list=iface-mgmt
/interface list member add interface=vrrp-mgmt-dns list=iface-mgmt
/interface list member add interface=vrrp-mgmt-ntp list=iface-mgmt
/interface list member add interface=vrrp-lan-gateway list=iface-lan
/interface list member add interface=vrrp-lan-dns list=iface-lan
/interface list member add interface=vrrp-lan-ntp list=iface-lan
/interface list member add interface=vrrp-dmz-gateway list=iface-dmz
/interface list member add interface=vrrp-dmz-dns list=iface-dmz
/interface list member add interface=vrrp-dmz-ntp list=iface-dmz
/interface list member add interface=vrrp-labnet-gateway list=iface-labnet
/interface list member add interface=vrrp-labnet-dns list=iface-labnet
/interface list member add interface=vrrp-labnet-ntp list=iface-labnet
/interface list member add interface=vrrp-security-gateway list=iface-security
/interface list member add interface=vrrp-security-dns list=iface-security
/interface list member add interface=vrrp-security-ntp list=iface-security
/interface list member add interface=vrrp-hypervisor-gateway list=iface-hypervisor
/interface list member add interface=vrrp-hypervisor-dns list=iface-hypervisor
/interface list member add interface=vrrp-hypervisor-ntp list=iface-hypervisor
/interface list member add interface=vlan-retro list=zone-local
/interface list member add interface=veth-snirouter list=zone-local
/interface list member add interface=veth-foxdns list=zone-local
/interface list member add interface=veth-foxdns-internal list=zone-local
/interface list member add interface=6to4-redfox list=zone-wan
/interface ovpn-server server add mac-address=FE:8C:1D:BF:62:A3 name=ovpn-server1
/interface wireguard peers add allowed-address=10.100.10.1/32 interface=wg-vpn name=fennec public-key="i/thQFtyJPTmq8QC44PV6QeETM6VlMQQs1tKWzTCqDU=" responder=yes
/interface wireguard peers add allowed-address=10.100.10.2/32 interface=wg-vpn name=capefox public-key="jay5WNfSd0Wo5k+FMweulWnaoxm1I82gom7JNkEjUBs=" responder=yes
/interface wireguard peers add allowed-address=10.100.10.3/32 interface=wg-vpn name=dori-phone public-key="keEyvK/AutdYbAYkkXffsvGEOCKZjlp6A0gDBsI8F0g=" responder=yes
/interface wireguard peers add allowed-address=10.100.10.4/32 interface=wg-vpn name=wizzy-laptop public-key="aL7QLtq2YoYVb0bhueG1InlbAdyZE0bmdmRPQ67rNjk=" responder=yes
/interface wireguard peers add allowed-address=10.99.10.2/32,10.99.12.0/24 endpoint-address=65.21.120.225 endpoint-port=13232 interface=wg-s2s name=icefox persistent-keepalive=25s public-key="6wduMejq9ytlzbwgurknWQVN+eUJ33iC/VbRFl6TJTE="
/interface wireguard peers add allowed-address=10.100.10.5/32 interface=wg-vpn name=wizzy-desktop public-key="L+Wtsz9ywb+MrY8nn+JzDRxAwEWDIpeSgbk32MA66B0=" responder=yes
/interface wireguard peers add allowed-address=10.99.10.1/32 endpoint-address=144.202.81.146 endpoint-port=13232 interface=wg-s2s name=redfox persistent-keepalive=25s public-key="s1COjkpfpzfQ05ZLNLGQrlEhomlzwHv+APvUABzbSh8="
/interface wireguard peers add allowed-address=10.100.10.6/32 interface=wg-vpn name=vixen public-key="Rc9Qxwi5lASfR1/urnWTKhuzXx0cDHVU+glTQgTbCBY=" responder=yes
/interface wireguard peers add allowed-address=10.99.10.3/32 interface=wg-s2s name=foxden-travel public-key="uI6WThZHWOMxg9aUxfAd2oTt/kY2TtOoyIDwaH2BIFM=" responder=yes
/iot lora traffic options set crc-errors=no
/iot lora traffic options set crc-errors=no
/ip address add address=10.1.1.2/16 interface=vlan-mgmt network=10.1.0.0
/ip address add address=192.168.88.100/24 interface=oob network=192.168.88.0
/ip address add address=10.2.1.2/16 interface=vlan-lan network=10.2.0.0
/ip address add address=10.3.1.2/16 interface=vlan-dmz network=10.3.0.0
/ip address add address=10.4.1.2/16 interface=vlan-labnet network=10.4.0.0
/ip address add address=10.5.1.2/16 interface=vlan-security network=10.5.0.0
/ip address add address=10.6.1.2/16 interface=vlan-hypervisor network=10.6.0.0
/ip address add address=10.99.1.2/16 interface=wg-s2s network=10.99.0.0
/ip address add address=10.100.0.1/16 interface=wg-vpn network=10.100.0.0
/ip address add address=10.1.0.1 interface=vrrp-mgmt-gateway network=10.1.0.1
/ip address add address=10.1.0.123 interface=vrrp-mgmt-ntp network=10.1.0.123
/ip address add address=10.1.0.53 interface=vrrp-mgmt-dns network=10.1.0.53
/ip address add address=10.2.0.1 interface=vrrp-lan-gateway network=10.2.0.1
/ip address add address=10.2.0.123 interface=vrrp-lan-ntp network=10.2.0.123
/ip address add address=10.2.0.53 interface=vrrp-lan-dns network=10.2.0.53
/ip address add address=10.3.0.1 interface=vrrp-dmz-gateway network=10.3.0.1
/ip address add address=10.3.0.123 interface=vrrp-dmz-ntp network=10.3.0.123
/ip address add address=10.3.0.53 interface=vrrp-dmz-dns network=10.3.0.53
/ip address add address=10.4.0.1 interface=vrrp-labnet-gateway network=10.4.0.1
/ip address add address=10.4.0.123 interface=vrrp-labnet-ntp network=10.4.0.123
/ip address add address=10.4.0.53 interface=vrrp-labnet-dns network=10.4.0.53
/ip address add address=10.5.0.1 interface=vrrp-security-gateway network=10.5.0.1
/ip address add address=10.5.0.123 interface=vrrp-security-ntp network=10.5.0.123
/ip address add address=10.5.0.53 interface=vrrp-security-dns network=10.5.0.53
/ip address add address=10.6.0.1 interface=vrrp-hypervisor-gateway network=10.6.0.1
/ip address add address=10.6.0.123 interface=vrrp-hypervisor-ntp network=10.6.0.123
/ip address add address=10.6.0.53 interface=vrrp-hypervisor-dns network=10.6.0.53
/ip address add address=10.7.1.2/16 interface=vlan-retro network=10.7.0.0
/ip address add address=172.17.0.1/24 interface=veth-snirouter network=172.17.0.0
/ip address add address=172.17.1.1/24 interface=veth-foxdns network=172.17.1.0
/ip address add address=172.17.2.1/24 interface=veth-foxdns-internal network=172.17.2.0
/ip cloud set update-time=no
/ip dhcp-client add default-route-distance=5 interface=wan script="/system/script/run wan-online-adjust\r\
    \n" use-peer-ntp=no
/ip dhcp-server config set store-leases-disk=never
/ip dhcp-server lease add address=10.2.10.3 comment=capefox lease-time=1d mac-address=7C:E7:12:81:29:9B server=dhcp-lan
/ip dhcp-server lease add address=10.6.10.2 comment=islandfox lease-time=1d mac-address=0A:98:86:2C:85:87 server=dhcp-hypervisor
/ip dhcp-server lease add address=10.2.10.1 comment=fennec lease-time=1d mac-address=00:02:C9:23:3C:E0 server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.1 comment=bengalfox lease-time=1d mac-address=50:6B:4B:4B:90:5E server=dhcp-lan
/ip dhcp-server lease add address=10.2.10.2 comment=wizzy-desktop lease-time=1d mac-address=EC:0D:9A:21:DF:70 server=dhcp-lan
/ip dhcp-server lease add address=10.1.12.1 comment=bengalfox-ipmi lease-time=1d mac-address=00:25:90:FF:CF:5B server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.4 comment=us-8-poe-sfp lease-time=1d mac-address=80:2A:A8:DE:F0:AE server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.11.1 comment=pdu-rack lease-time=1d mac-address=70:A7:41:F8:13:09 server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.2 comment=switch-den lease-time=1d mac-address=24:5A:4C:A6:6B:9A server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.3 comment=switch-rack-agg lease-time=1d mac-address=24:5A:4C:56:41:C4 server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.11.2 comment=ups-rack lease-time=1d mac-address=00:C0:B7:E8:B2:A0 server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.1 comment=unifi lease-time=1d mac-address=24:5A:4C:8A:23:3F server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.6 comment=ap-backyard lease-time=1d mac-address=68:D7:9A:1F:57:E2 server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.7 comment=ap-corridor-upper lease-time=1d mac-address=60:22:32:1D:48:15 server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.10 comment=switch-dori-office-agg lease-time=1d mac-address=AC:8B:A9:A6:E7:EE server=dhcp-mgmt
/ip dhcp-server lease add address=10.6.11.2 comment=telegraf lease-time=1d mac-address=42:FE:0C:C8:E0:F5 server=dhcp-hypervisor
/ip dhcp-server lease add address=10.2.11.2 comment=syncthing lease-time=1d mac-address=AE:FC:DD:8B:33:76 server=dhcp-lan
/ip dhcp-server lease add address=10.1.11.3 comment=ups-dori-office lease-time=1d mac-address=00:0C:15:04:39:93 server=dhcp-mgmt
/ip dhcp-server lease add address=10.2.12.3 comment=printer lease-time=1d mac-address=E8:D8:D1:79:F5:98 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.1 comment=hue-downstairs lease-time=1d mac-address=00:17:88:AC:31:4B server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.2 comment=homeassistant lease-time=1d mac-address=D8:3A:DD:B2:52:89 server=dhcp-lan
/ip dhcp-server lease add address=10.5.11.2 comment=camera-living-room lease-time=1d mac-address=68:D7:9A:CF:30:09 server=dhcp-security
/ip dhcp-server lease add address=10.2.11.3 comment=plex lease-time=1d mac-address=00:16:3E:CA:7E:03 server=dhcp-lan
/ip dhcp-server lease add address=10.6.11.1 comment=prometheus lease-time=1d mac-address=4A:97:18:7B:69:10 server=dhcp-hypervisor
/ip dhcp-server lease add address=10.2.11.5 comment=grafana lease-time=1d mac-address=7E:18:E9:41:A9:6C server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.6 comment=kiwix lease-time=1d mac-address=00:16:3E:CA:7E:01 server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.8 comment=dldr lease-time=1d mac-address=CA:1B:F1:2C:6C:B3 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.7 comment=clock-nixie-zen lease-time=1d mac-address=E0:4F:43:C2:BA:C2 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.7 comment=airgradient-bedroom lease-time=1d mac-address=94:B5:55:2D:82:54 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.6 comment=airgradient-living-room lease-time=1d mac-address=0C:B8:15:D8:B8:EC server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.5 comment=airgradient-dori-office lease-time=1d mac-address=94:B5:55:2D:78:08 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.9 comment=vacuum-neato lease-time=1d mac-address=40:BD:32:95:26:C0 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.4 comment=homepod-hobby-room lease-time=1d mac-address=F4:34:F0:4B:87:1A server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.5 comment=homepod-bedroom lease-time=1d mac-address=94:EA:32:84:DB:90 server=dhcp-lan
/ip dhcp-server lease add address=10.2.14.1 comment=dori-phone lease-time=1d mac-address=1A:15:4A:91:20:75 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.6 comment=appletv-living-room lease-time=1d mac-address=58:D3:49:E4:02:2D server=dhcp-lan
/ip dhcp-server lease add address=10.2.15.1 comment=nintendo-switch-wired lease-time=1d mac-address=00:0E:C6:D2:C9:DD server=dhcp-lan
/ip dhcp-server lease add address=10.2.14.3 comment=wizzy-phone lease-time=1d mac-address=1E:44:79:62:9A:8D server=dhcp-lan
/ip dhcp-server lease add address=10.2.14.4 comment=wizzy-watch lease-time=1d mac-address=2E:47:59:D7:CF:2D server=dhcp-lan
/ip dhcp-server lease add address=10.2.10.6 comment=wizzy-laptop-2 lease-time=1d mac-address=88:66:5A:53:5E:40 server=dhcp-lan
/ip dhcp-server lease add address=10.2.10.5 comment=wizzy-laptop lease-time=1d mac-address=F0:2F:4B:15:2E:54 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.10 comment=amp-living-room lease-time=1d mac-address=EC:F4:51:D0:8C:AF server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.8 comment=clock-nixie-dori lease-time=1d mac-address=C4:5B:BE:63:3A:2E server=dhcp-lan
/ip dhcp-server lease add address=10.2.14.2 comment=dori-watch lease-time=1d mac-address=72:68:A8:0D:18:01 server=dhcp-lan
/ip dhcp-server lease add address=10.3.10.5 comment=spaceage-web lease-time=1d mac-address=62:BF:FB:E4:89:5D server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.4 comment=spaceage-gmod lease-time=1d mac-address=5E:47:05:FC:F8:90 server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.3 comment=ut2004 lease-time=1d mac-address=02:43:39:4D:B6:AA server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.7 comment=factorio lease-time=1d mac-address=36:16:0C:C9:E8:0B server=dhcp-dmz
/ip dhcp-server lease add address=10.2.13.11 comment=uplift-wizzy-desk lease-time=1d mac-address=40:91:51:52:11:F7 server=dhcp-lan
/ip dhcp-server lease add address=10.6.12.1 comment=islandfox-ipmi lease-time=1d mac-address=04:7B:CB:44:C0:DD server=dhcp-hypervisor
/ip dhcp-server lease add address=10.2.10.4 client-id=capefox-wired comment=capefox-wired lease-time=1d mac-address=00:30:93:12:12:38 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.11 comment=homepod-dori-office lease-time=1d mac-address=04:99:B9:66:DE:D0 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.12 comment=august-connect-front-door lease-time=1d mac-address=D8:61:62:12:6A:08 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.13 comment=homepod-den lease-time=1d mac-address=04:99:B9:9E:9B:95 server=dhcp-lan
/ip dhcp-server lease add address=10.5.11.1 comment=camera-front-door lease-time=1d mac-address=E4:38:83:0E:1F:D3 server=dhcp-security
/ip dhcp-server lease add address=10.1.10.9 comment=switch-dori-office-tv lease-time=1d mac-address=F4:92:BF:A3:E8:E8 server=dhcp-mgmt
/ip dhcp-server lease add address=10.2.12.14 comment=homepod-wizzy-office lease-time=1d mac-address=04:99:B9:79:EE:C9 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.15 comment=tesla-model-3 lease-time=1d mac-address=CC:88:26:27:41:29 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.16 comment=tesla-wall-charger lease-time=1d mac-address=98:ED:5C:9B:79:CF server=dhcp-lan
/ip dhcp-server lease add address=10.5.10.1 comment=nvr lease-time=1d mac-address=60:22:32:F1:BF:71 server=dhcp-security
/ip dhcp-server lease add address=10.4.10.1 comment=bambu-x1 lease-time=1d mac-address=08:FB:EA:02:64:96 server=dhcp-labnet
/ip dhcp-server lease add address=10.2.12.18 comment=hue-sync-box lease-time=1d mac-address=C4:29:96:0B:9C:82 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.20 comment=custom-garage-door lease-time=1d mac-address=4C:EB:D6:0B:80:73 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.16 comment=airgradient-den lease-time=1d mac-address=0C:B8:15:C4:B3:74 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.15 comment=custom-current-clamp-main lease-time=1d mac-address=40:91:51:51:D0:A6 server=dhcp-lan
/ip dhcp-server lease add address=10.5.11.4 comment=camera-back-right lease-time=1d mac-address=D0:21:F9:99:60:DA server=dhcp-security
/ip dhcp-server lease add address=10.5.11.3 comment=camera-front-right lease-time=1d mac-address=70:A7:41:5F:DB:54 server=dhcp-security
/ip dhcp-server lease add address=10.5.11.5 comment=camera-front-left lease-time=1d mac-address=70:A7:41:0B:11:36 server=dhcp-security
/ip dhcp-server lease add address=10.2.13.17 comment=airgradient-wizzy-office lease-time=1d mac-address=0C:B8:15:C4:B8:D0 server=dhcp-lan
/ip dhcp-server lease add address=10.2.10.7 comment=mbp-mark-dietzer lease-time=1d mac-address=BC:D0:74:45:61:FB server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.17 comment=august-connect-back-door-upper lease-time=1d mac-address=2C:9F:FB:16:5F:B7 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.18 comment=uplift-dori-desk lease-time=1d mac-address=40:91:51:51:E8:B6 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.19 comment=nanoleaf-lines-wizzy lease-time=1d mac-address=80:8A:F7:03:55:58 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.20 comment=nanoleaf-shapes-dori lease-time=1d mac-address=80:8A:F7:03:EA:58 server=dhcp-lan
/ip dhcp-server lease add address=10.2.14.5 comment=dori-ipad lease-time=1d mac-address=6E:42:DD:F2:32:D8 server=dhcp-lan
/ip dhcp-server lease add address=10.1.10.11 comment=ap-living-room lease-time=1d mac-address=60:22:32:83:6D:9E server=dhcp-mgmt
/ip dhcp-server lease add address=10.2.14.6 comment=dori-remarkable lease-time=1d mac-address=C0:84:7D:20:57:C0 server=dhcp-lan
/ip dhcp-server lease add address=10.2.10.8 comment=thunderbolt-10g lease-time=1d mac-address=00:30:93:12:12:38 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.9 comment=custom-filament-dryer lease-time=1d mac-address=0C:B8:15:D5:C0:88 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.21 comment=laundry-washer lease-time=1d mac-address=88:57:1D:85:70:9A server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.22 comment=laundry-dryer lease-time=1d mac-address=88:57:1D:85:70:A1 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.24 comment=appletv-dori-office lease-time=1d mac-address=9C:3E:53:1C:20:C0 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.25 comment=thermostat-nest-corridor-upper lease-time=1d mac-address=64:16:66:9F:DE:CA server=dhcp-lan
/ip dhcp-server lease add address=10.6.11.3 comment=akvorado lease-time=1d mac-address=BA:11:EF:53:38:7A server=dhcp-hypervisor
/ip dhcp-server lease add address=10.2.13.10 comment=custom-led-microscope lease-time=1d mac-address=D4:F9:8D:70:82:F6 server=dhcp-lan
/ip dhcp-server lease add address=10.3.11.2 comment=pawbfun-2 lease-time=1d mac-address=FA:3F:4C:4C:97:2C server=dhcp-dmz
/ip dhcp-server lease add address=10.3.11.1 comment=pawbfun-1 lease-time=1d mac-address=CE:5A:B6:F7:F3:EB server=dhcp-dmz
/ip dhcp-server lease add address=10.2.13.2 comment=custom-bench-psu lease-time=1d mac-address=E0:98:06:24:8D:06 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.28 comment=nanoleaf-shapes-den lease-time=1d mac-address=80:8A:F7:03:E2:1A server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.26 comment=homepod-living-room lease-time=1d mac-address=AC:BC:B5:D0:56:AE server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.13 comment=apt-mirror lease-time=1d mac-address=02:40:12:6C:D7:1A server=dhcp-lan
/ip dhcp-server lease add address=10.3.11.3 comment=blfcmasto lease-time=1d mac-address=DE:E4:0A:E4:BB:D2 server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.1 comment=foxcaves lease-time=1d mac-address=A6:92:B3:48:21:9D server=dhcp-dmz
/ip dhcp-server lease add address=10.4.10.2 comment=carvera-controller lease-time=1d mac-address=38:DE:AD:30:57:0F server=dhcp-labnet
/ip dhcp-server lease add address=10.2.12.27 comment=hue-upstairs lease-time=1d mac-address=00:17:88:61:02:4E server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.21 comment=led-strip-dori-office-ceiling lease-time=1d mac-address=C4:DE:E2:B2:D2:C7 server=dhcp-lan
/ip dhcp-server lease add address=10.1.10.13 comment=switch-living-room lease-time=1d mac-address=E4:38:83:8C:AA:DA server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.12 comment=switch-rack lease-time=1d mac-address=D8:B3:70:1E:9E:3A server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.5 comment=switch-dori-office lease-time=1d mac-address=60:22:32:39:77:9C server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.8 comment=crs-305 lease-time=1d mac-address=FF:FF:AA:EA:C8:7C server=dhcp-mgmt
/ip dhcp-server lease add address=10.5.11.6 comment=camera-back-door-upper lease-time=1d mac-address=D0:21:F9:94:97:13 server=dhcp-security
/ip dhcp-server lease add address=10.1.10.14 comment=switch-den-desk lease-time=1d mac-address=74:83:C2:FF:87:16 server=dhcp-mgmt
/ip dhcp-server lease add address=10.5.11.7 comment=camera-den lease-time=1d mac-address=E4:38:83:0E:E4:A3 server=dhcp-security
/ip dhcp-server lease add address=10.2.11.16 comment=scrypted lease-time=1d mac-address=52:81:BA:81:D3:E2 server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.15 comment=bengalfox-syncthing lease-time=1d mac-address=6C:DE:77:10:02:AA server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.23 comment=uplift-den-desk lease-time=1d mac-address=40:91:51:45:98:06 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.24 comment=custom-shaving-mirror lease-time=1d mac-address=44:17:93:16:03:94 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.25 comment=led-strip-bambu-x1 lease-time=1d mac-address=0C:B8:15:C3:24:2C server=dhcp-lan
/ip dhcp-server lease add address=10.4.10.3 comment=carvera lease-time=1d mac-address=EC:C7:00:1C:E3:2D server=dhcp-labnet
/ip dhcp-server lease add address=10.2.12.29 comment=tv-dori-office lease-time=1d mac-address=A8:23:FE:39:3A:1C server=dhcp-lan
/ip dhcp-server lease add address=10.7.10.1 comment=mister lease-time=1d mac-address=02:03:04:05:06:07 server=dhcp-retro
/ip dhcp-server lease add address=10.7.10.2 comment=wii lease-time=1d mac-address=00:27:09:8A:A7:49 server=dhcp-retro
/ip dhcp-server lease add address=10.7.10.3 comment=wyse98 lease-time=1d mac-address=00:80:64:77:75:27 server=dhcp-retro
/ip dhcp-server lease add address=10.2.15.3 client-id=1:4:3:d6:71:42:1a comment=nintendo-3ds lease-time=1d mac-address=04:03:D6:71:42:1A server=dhcp-lan
/ip dhcp-server lease add address=10.1.13.1 comment=tape-library lease-time=1d mac-address=00:0E:11:14:70:8B server=dhcp-mgmt
/ip dhcp-server lease add address=10.2.11.9 comment=nzbget lease-time=1d mac-address=F2:73:89:CC:9E:E4 server=dhcp-lan
/ip dhcp-server lease add address=10.7.10.4 comment=nuc7 lease-time=1d mac-address=B8:AE:ED:7C:1E:71 server=dhcp-retro
/ip dhcp-server lease add address=10.7.10.5 comment=ps2 lease-time=1d mac-address=00:27:09:FF:A7:49 server=dhcp-retro
/ip dhcp-server lease add address=10.3.10.8 comment=minecraft lease-time=1d mac-address=36:16:0C:C9:E8:B0 server=dhcp-dmz
/ip dhcp-server lease add address=10.2.12.30 comment=streamdeckpi lease-time=1d mac-address=D8:3A:DD:40:CA:F1 server=dhcp-lan
/ip dhcp-server lease add address=10.4.10.4 comment=anycubic-photon-mono-m5s lease-time=1d mac-address=3E:DE:77:0C:AB:B8 server=dhcp-labnet
/ip dhcp-server lease add address=10.2.11.17 comment=htpl lease-time=1d mac-address=F2:6C:78:D6:EE:E6 server=dhcp-lan
/ip dhcp-server lease add address=10.5.11.8 comment=camera-garage lease-time=1d mac-address=F4:E2:C6:0C:3F:C3 server=dhcp-security
/ip dhcp-server lease add address=10.4.10.5 comment=laser-controller lease-time=1d mac-address=8C:16:45:46:05:22 server=dhcp-labnet
/ip dhcp-server lease add address=10.2.13.27 comment=humidity-switch-bathroom-upper lease-time=1d mac-address=70:03:9F:37:4D:3E server=dhcp-lan
/ip dhcp-server lease add address=10.3.10.10 comment=website lease-time=1d mac-address=AE:75:D4:40:07:76 server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.9 comment=spaceage-website lease-time=1d mac-address=5E:1A:40:6A:64:06 server=dhcp-dmz
/ip dhcp-server lease add address=10.2.11.18 comment=jellyfin lease-time=1d mac-address=00:16:3E:CA:7E:18 server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.19 comment=ollama lease-time=1d mac-address=00:16:3E:CA:7E:99 server=dhcp-lan
/ip dhcp-server lease add address=10.2.12.31 comment=ecoflow-delta-pro lease-time=1d mac-address=4C:EB:D6:D6:3C:9C server=dhcp-lan
/ip dhcp-server lease add address=10.2.20.20 comment=ht802 lease-time=1d mac-address=00:0B:82:8C:C9:7C server=dhcp-lan
/ip dhcp-server lease add address=10.2.16.1 comment=grandstream-ht812 lease-time=1d mac-address=C0:74:AD:F4:16:9B server=dhcp-lan
/ip dhcp-server lease add address=10.1.10.15 comment=switch-dori-office-tv lease-time=1d mac-address=F4:E2:C6:AC:81:3D server=dhcp-mgmt
/ip dhcp-server lease add address=10.1.10.16 comment=switch-dori-office-desk lease-time=1d mac-address=F4:E2:C6:AC:81:DC server=dhcp-mgmt
/ip dhcp-server lease add address=10.5.11.9 comment=camera-server-room lease-time=1d mac-address=F4:E2:C6:0C:E8:3C server=dhcp-security
/ip dhcp-server lease add address=10.1.13.2 comment=pikvm-rack lease-time=1d mac-address=D8:3A:DD:A3:82:A8 server=dhcp-mgmt
/ip dhcp-server lease add address=10.3.10.11 comment=archlinux lease-time=1d mac-address=CA:1B:F1:2D:6D:B3 server=dhcp-dmz
/ip dhcp-server lease add address=10.6.11.4 comment=auth lease-time=1d mac-address=A6:92:B3:68:21:9D server=dhcp-hypervisor
/ip dhcp-server lease add address=10.3.10.12 comment=e621 lease-time=1d mac-address=F2:6C:78:D6:DD:E6 server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.13 comment=furaffinity lease-time=1d mac-address=F2:6C:78:D6:DE:E6 server=dhcp-dmz
/ip dhcp-server lease add address=10.3.10.2 comment=git lease-time=1d mac-address=A6:92:B3:68:D1:AD server=dhcp-dmz
/ip dhcp-server lease add address=10.2.13.28 comment=custom-dori-rca-switcher lease-time=1d mac-address=28:CD:C1:0B:31:44 server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.29 comment=dori-office-hifi lease-time=1d mac-address=B8:27:EB:BF:3A:4C server=dhcp-lan
/ip dhcp-server lease add address=10.2.13.30 comment=btproxy-living-room lease-time=1d mac-address=94:E6:86:48:E9:87 server=dhcp-lan
/ip dhcp-server lease add address=10.2.11.12 comment=restic lease-time=1d mac-address=A6:92:B3:68:DD:AD server=dhcp-lan
/ip dhcp-server lease add address=10.5.10.3 client-id=1:b8:27:eb:ed:f:4b comment=crossfox lease-time=1d mac-address=B8:27:EB:ED:0F:4B server=dhcp-security
/ip dhcp-server network add address=10.1.0.0/16 dns-server=10.1.0.53 domain=foxden.network gateway=10.1.0.1 netmask=16 ntp-server=10.1.0.123
/ip dhcp-server network add address=10.2.0.0/16 boot-file-name=ipxe-arch-signed.efi dns-server=10.2.0.53 domain=foxden.network gateway=10.2.0.1 netmask=16 next-server=10.2.0.1 ntp-server=10.2.0.123
/ip dhcp-server network add address=10.3.0.0/16 dns-server=10.3.0.53 domain=foxden.network gateway=10.3.0.1 netmask=16 ntp-server=10.3.0.123
/ip dhcp-server network add address=10.4.0.0/16 boot-file-name=ipxe-arch-signed.efi dns-server=10.4.0.53 domain=foxden.network gateway=10.4.0.1 netmask=16 next-server=10.4.0.1 ntp-server=10.4.0.123
/ip dhcp-server network add address=10.5.0.0/16 dns-server=10.5.0.53 domain=foxden.network gateway=10.5.0.1 netmask=16 ntp-server=10.5.0.123
/ip dhcp-server network add address=10.6.0.0/16 boot-file-name=ipxe-arch-signed.efi dns-server=10.6.0.53 domain=foxden.network gateway=10.6.0.1 netmask=16 next-server=10.6.0.1 ntp-server=10.6.0.123
/ip dhcp-server network add address=10.7.0.0/16 dns-server=10.7.1.1 domain=foxden.network gateway=10.7.1.1 netmask=16 ntp-server=10.7.1.1
/ip dhcp-server network add address=192.168.88.0/24 dns-none=yes
/ip dns set cache-max-ttl=1d max-udp-packet-size=512 verify-doh-cert=yes
/ip dns static add name=wpad ttl=5m type=NXDOMAIN
/ip dns static add name=wpad.foxden.network ttl=5m type=NXDOMAIN
/ip dns static add forward-to=172.17.1.2 match-subdomain=yes name=foxden.test type=FWD
/ip firewall address-list add address=router.foxden.network list=wan-ips
/ip firewall address-list add address=router-backup.foxden.network list=wan-ips
/ip firewall address-list add address=10.1.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.2.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.3.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.4.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.5.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.6.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.7.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.8.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.9.0.0/23 list=local-dns-ip
/ip firewall address-list add address=10.100.0.1 list=local-dns-ip
/ip firewall filter add action=reject chain=forward comment=invalid connection-state=invalid reject-with=icmp-admin-prohibited
/ip firewall filter add action=fasttrack-connection chain=forward comment="related, established" connection-state=established,related hw-offload=yes
/ip firewall filter add action=accept chain=forward comment="related, established" connection-state=established,related
/ip firewall filter add action=accept chain=forward comment="dstnat'd" connection-nat-state=dstnat
/ip firewall filter add action=accept chain=forward out-interface-list=zone-wan
/ip firewall filter add action=accept chain=forward in-interface=wg-vpn
/ip firewall filter add action=accept chain=forward in-interface=oob
/ip firewall filter add action=accept chain=forward in-interface-list=iface-mgmt
/ip firewall filter add action=accept chain=forward comment="Prometheus -> NodeExporter" dst-port=9100 in-interface-list=iface-hypervisor protocol=tcp src-address=10.6.11.1
/ip firewall filter add action=jump chain=forward comment="LAN allowlist" jump-target=lan-out-forward out-interface-list=iface-lan
/ip firewall filter add action=jump chain=forward comment="MGMT allowlist" jump-target=mgmt-out-forward out-interface-list=iface-mgmt
/ip firewall filter add action=jump chain=forward comment="LabNet allowlist" jump-target=labnet-out-forward out-interface-list=iface-labnet
/ip firewall filter add action=jump chain=forward comment="Hypervisor allowlist" jump-target=hypervisor-out-forward out-interface-list=iface-hypervisor
/ip firewall filter add action=jump chain=forward comment="Security allowlist" jump-target=security-out-forward out-interface-list=iface-security
/ip firewall filter add action=jump chain=forward comment="Retro allowlist" jump-target=retro-out-forward out-interface=vlan-retro
/ip firewall filter add action=jump chain=forward comment="S2S allowlist" jump-target=s2s-out-forward out-interface=wg-s2s
/ip firewall filter add action=accept chain=forward out-interface-list=iface-dmz
/ip firewall filter add action=reject chain=forward reject-with=icmp-admin-prohibited
/ip firewall filter add action=accept chain=mgmt-out-forward comment="Hypervisor -> SNMP" dst-port=161 in-interface-list=iface-hypervisor protocol=udp
/ip firewall filter add action=accept chain=mgmt-out-forward comment="HomeAssistant -> SNMP" dst-port=161 in-interface-list=iface-lan protocol=udp src-address=10.2.12.2
/ip firewall filter add action=accept chain=mgmt-out-forward comment="NAS -> SNMP" dst-port=161 in-interface-list=iface-lan protocol=udp src-address=10.2.11.1
/ip firewall filter add action=accept chain=mgmt-out-forward comment="LAN -> UniFi" dst-address=10.1.10.1 in-interface-list=iface-lan
/ip firewall filter add action=accept chain=retro-out-forward comment="LAN -> Retro" in-interface-list=iface-lan
/ip firewall filter add action=accept chain=lan-out-forward comment=HomeAssistant dst-address=10.2.12.2 dst-port=80,443,8080,8443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment="HomeAssistant MQTT" dst-address=10.2.12.2 dst-port=1883 in-interface-list=iface-security protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=Grafana dst-address=10.2.11.5 dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=NAS dst-address=10.2.11.1 dst-port=22,80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=restic dst-address=10.2.11.12 dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=syncthing dst-address=10.2.11.2 dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=bengalfox-syncthing dst-address=10.2.11.15 dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=Hashtopolis dst-address=10.2.11.17 dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=jellyfin disabled=yes dst-address=10.2.11.18 dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment=Plex dst-address=10.2.11.3 dst-port=32400 protocol=tcp
/ip firewall filter add action=accept chain=lan-out-forward comment="LabNet -> NAS" dst-address=10.2.11.1 in-interface-list=iface-labnet
/ip firewall filter add action=accept chain=lan-out-forward comment="Retro -> NAS" dst-address=10.2.11.1 in-interface=vlan-retro
/ip firewall filter add action=accept chain=labnet-out-forward comment="Bambu X1 MQTT" dst-address=10.4.10.1 dst-port=8883 protocol=tcp
/ip firewall filter add action=accept chain=security-out-forward comment="LAN -> NVR" dst-address=10.5.10.1 in-interface-list=iface-lan
/ip firewall filter add action=accept chain=hypervisor-out-forward comment="auth (TCP)" dst-address=10.6.11.4 dst-port=80,443,1812 protocol=tcp
/ip firewall filter add action=accept chain=hypervisor-out-forward comment="auth (UDP)" dst-address=10.6.11.4 dst-port=1812 protocol=udp
/ip firewall filter add action=accept chain=s2s-out-forward comment="LAN -> IceFox" disabled=yes dst-address=10.99.10.2 in-interface-list=iface-lan
/ip firewall filter add action=accept chain=s2s-out-forward comment="LAN -> IceFoxSub" disabled=yes dst-address=10.99.12.0/24 in-interface-list=iface-lan
/ip firewall filter add action=accept chain=s2s-out-forward comment=IceFox:Sub dst-address=10.99.12.0/24 in-interface-list=zone-local
/ip firewall filter add action=accept chain=s2s-out-forward comment=IceFox dst-address=10.99.10.2 in-interface-list=zone-local
/ip firewall filter add action=accept chain=input connection-state=established,related
/ip firewall filter add action=accept chain=input protocol=ipv6-encap
/ip firewall filter add action=accept chain=input protocol=icmp
/ip firewall filter add action=accept chain=input comment="HTTP(S)" dst-port=80,443 protocol=tcp
/ip firewall filter add action=accept chain=input comment=BGP dst-port=179 protocol=tcp
/ip firewall filter add action=accept chain=input comment=WireGuard dst-port=13231-13232 protocol=udp
/ip firewall filter add action=accept chain=input in-interface=lo
/ip firewall filter add action=accept chain=input in-interface=oob
/ip firewall filter add action=accept chain=input in-interface-list=zone-local
/ip firewall filter add action=reject chain=input reject-with=icmp-admin-prohibited
/ip firewall mangle add action=change-mss chain=forward comment="Clamp MSS" new-mss=clamp-to-pmtu protocol=tcp tcp-flags=syn
/ip firewall nat add action=endpoint-independent-nat chain=srcnat disabled=yes out-interface=wan protocol=udp randomise-ports=yes
/ip firewall nat add action=masquerade chain=srcnat out-interface=wan
/ip firewall nat add action=masquerade chain=srcnat out-interface=wg-s2s
/ip firewall nat add action=masquerade chain=srcnat src-address=172.17.0.0/16
/ip firewall nat add action=dst-nat chain=dstnat comment=spaceage-website dst-address=55.69.1.1 in-interface-list=zone-local to-addresses=10.3.10.9
/ip firewall nat add action=dst-nat chain=dstnat comment=spaceage-web dst-address=55.69.1.2 in-interface-list=zone-local to-addresses=10.3.10.5
/ip firewall nat add action=jump chain=dstnat comment=dns dst-address=55.53.53.53 in-interface-list=zone-local jump-target=dns-port-forward to-addresses=10.3.0.53
/ip firewall nat add action=jump chain=dstnat comment=Hairpin dst-address=REMOVED jump-target=port-forward
/ip firewall nat add action=jump chain=dstnat comment="DNS forward" dst-address-list=local-dns-ip jump-target=dns-port-forward
/ip firewall nat add action=jump chain=dstnat comment="Hairpin fallback" dst-address=REMOVED jump-target=port-forward
/ip firewall nat add action=jump chain=dstnat comment=External in-interface-list=zone-wan jump-target=port-forward
/ip firewall nat add action=dst-nat chain=port-forward comment="HTTP(S)" dst-port=80,443 protocol=tcp to-addresses=172.17.0.2
/ip firewall nat add action=dst-nat chain=port-forward comment=FoxDNS dst-port=53 protocol=tcp to-addresses=172.17.1.2
/ip firewall nat add action=dst-nat chain=port-forward comment=FoxDNS dst-port=53 protocol=udp to-addresses=172.17.1.2
/ip firewall nat add action=dst-nat chain=port-forward comment="SpaceAge GMod" dst-port=27015 protocol=udp to-addresses=10.3.10.4
/ip firewall nat add action=dst-nat chain=port-forward comment=Minecraft dst-port=25565 protocol=tcp to-addresses=10.3.10.8
/ip firewall nat add action=dst-nat chain=port-forward comment=Factorio dst-port=34197 protocol=udp to-addresses=10.3.10.7
/ip firewall nat add action=dst-nat chain=port-forward comment=Plex dst-port=32400 protocol=tcp to-addresses=10.2.11.3
/ip firewall nat add action=dst-nat chain=dns-port-forward comment=FoxDNS dst-port=53 protocol=tcp to-addresses=172.17.2.2
/ip firewall nat add action=dst-nat chain=dns-port-forward comment=FoxDNS dst-port=53 protocol=udp to-addresses=172.17.2.2
/ip firewall nat add action=dst-nat chain=dns-port-forward comment="FoxDNS Prometheus" dst-port=5302 protocol=tcp to-addresses=172.17.2.2 to-ports=9001
/ip firewall nat add action=dst-nat chain=dns-port-forward comment="FoxDNS Prometheus External" dst-port=5301 protocol=tcp to-addresses=172.17.1.2 to-ports=9001
/ip firewall nat add action=masquerade chain=srcnat dst-address=10.2.1.1 src-address=10.100.0.0/16
/ip firewall nat add action=masquerade chain=srcnat dst-address=10.2.1.2 src-address=10.100.0.0/16
/ip ipsec profile set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip route add disabled=no distance=10 dst-address=0.0.0.0/0 gateway=10.1.0.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add blackhole disabled=no dst-address=55.69.0.0/16 gateway="" routing-table=main suppress-hw-offload=no
/ipv6 route add disabled=no dst-address=::/0 gateway=2a0e:7d44:f000:b::1 routing-table=main
/ipv6 route add blackhole disabled=no dst-address=2a0e:7d44:f00b::/48 gateway="" routing-table=main suppress-hw-offload=no
/ipv6 route add blackhole disabled=no distance=1 dst-address=2a0e:7d44:f069::/48 gateway="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ipv6 route add blackhole disabled=no distance=1 dst-address=2a0e:7d44:f00a::/48 gateway="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www-ssl certificate=router-backup.foxden.network disabled=no tls-version=only-1.2
/ip service set api disabled=yes
/ip service set winbox address=10.0.0.0/8
/ip service set api-ssl certificate=*6 tls-version=only-1.2
/ip smb shares set [ find default=yes ] directory=/pub
/ip ssh set forwarding-enabled=local strong-crypto=yes
/ip tftp add real-filename=/ipxe-arch.efi req-filename=ipxe-arch.efi
/ip tftp add real-filename=/ipxe-arch.efi req-filename=/ipxe-arch.efi
/ip tftp add real-filename=/ipxe-arch-signed.efi req-filename=ipxe-arch-signed.efi
/ip tftp add real-filename=/ipxe-arch-signed.efi req-filename=/ipxe-arch-signed.efi
/ip tftp add allow=no
/ip tftp settings set max-block-size=65536
/ip traffic-flow set enabled=yes sampling-interval=1 sampling-space=1
/ip traffic-flow target add dst-address=10.6.11.4 src-address=10.6.1.1 version=ipfix
/ipv6 address add address=2a0e:7d44:f000:b::1:2 advertise=no interface=6to4-redfox
/ipv6 address add address=2a0e:7d44:f069:1::1:2 interface=vlan-mgmt
/ipv6 address add address=2a0e:7d44:f069:2::1:2 interface=vlan-lan
/ipv6 address add address=2a0e:7d44:f069:3::1:2 interface=vlan-dmz
/ipv6 address add address=2a0e:7d44:f069:4::1:2 interface=vlan-labnet
/ipv6 address add address=2a0e:7d44:f069:5::1:2 interface=vlan-security
/ipv6 address add address=2a0e:7d44:f069:6::1:2 interface=vlan-hypervisor
/ipv6 address add address=2a0e:7d44:f069:1::1 advertise=no interface=vrrp-mgmt-gateway6
/ipv6 address add address=2a0e:7d44:f069:2::1 advertise=no interface=vrrp-lan-gateway6
/ipv6 address add address=2a0e:7d44:f069:3::1 advertise=no interface=vrrp-dmz-gateway6
/ipv6 address add address=2a0e:7d44:f069:4::1 advertise=no interface=vrrp-labnet-gateway6
/ipv6 address add address=2a0e:7d44:f069:5::1 advertise=no interface=vrrp-security-gateway6
/ipv6 address add address=2a0e:7d44:f069:6::1 advertise=no interface=vrrp-hypervisor-gateway6
/ipv6 firewall address-list add address=2a0e:7d44:f00b::/48 list=bgp-redfox
/ipv6 firewall address-list add address=2a0e:7d44:f069::/48 comment=primary list=bgp-redfox
/ipv6 firewall filter add action=accept chain=forward out-interface-list=iface-dmz
/ipv6 firewall filter add action=reject chain=forward comment=invalid connection-state=invalid reject-with=icmp-admin-prohibited
/ipv6 firewall filter add action=fasttrack-connection chain=forward comment="related, established" connection-state=established,related
/ipv6 firewall filter add action=accept chain=forward comment="related, established" connection-state=established,related
/ipv6 firewall filter add action=accept chain=forward protocol=icmpv6
/ipv6 firewall filter add action=accept chain=forward in-interface=oob
/ipv6 firewall filter add action=accept chain=forward in-interface-list=iface-mgmt
/ipv6 firewall filter add action=accept chain=forward out-interface-list=zone-wan
/ipv6 firewall filter add action=reject chain=forward reject-with=icmp-admin-prohibited
/ipv6 firewall filter add action=accept chain=input connection-state=established,related
/ipv6 firewall filter add action=accept chain=input protocol=icmpv6
/ipv6 firewall filter add action=accept chain=input comment="HTTP(S)" dst-port=80,443 protocol=tcp
/ipv6 firewall filter add action=accept chain=input comment=WireGuard dst-port=13231-13232 protocol=udp
/ipv6 firewall filter add action=accept chain=input in-interface=lo
/ipv6 firewall filter add action=accept chain=input in-interface=oob
/ipv6 firewall filter add action=accept chain=input in-interface-list=zone-local
/ipv6 firewall filter add action=reject chain=input reject-with=icmp-admin-prohibited
/ipv6 nd set [ find default=yes ] advertise-dns=no disabled=yes ra-interval=1m-3m
/ipv6 nd add advertise-dns=no disabled=yes interface=vlan-dmz ra-interval=1m-3m
/ipv6 nd add advertise-dns=no disabled=yes interface=vlan-hypervisor ra-interval=1m-3m
/ipv6 nd add advertise-dns=no disabled=yes interface=vlan-labnet ra-interval=1m-3m
/ipv6 nd add advertise-dns=no disabled=yes interface=vlan-lan ra-interval=1m-3m
/ipv6 nd add advertise-dns=no disabled=yes interface=vlan-mgmt ra-interval=1m-3m
/ipv6 nd add advertise-dns=no disabled=yes interface=vlan-security ra-interval=1m-3m
/ipv6 nd prefix default set preferred-lifetime=15m valid-lifetime=1h
/radius add accounting-port=1812 address=10.2.11.20 require-message-auth=no service=login
/radius add accounting-port=1812 address=10.2.10.1 disabled=yes require-message-auth=no service=login
/routing bgp connection add address-families=ipv6 as=64602 connect=yes disabled=no listen=yes local.address=10.99.1.2 .role=ebgp multihop=yes name=bgp-redfox output.default-originate=never .network=bgp-redfox remote.address=10.99.10.1/32 .as=207618 router-id=10.99.1.2 routing-table=main
/snmp set contact=admin@foxden.network enabled=yes location="Server room" trap-generators=""
/system clock set time-zone-autodetect=no time-zone-name=America/Los_Angeles
/system identity set name=router-backup
/system logging set 0 topics=info,!debug
/system logging add topics=container,info
/system logging add disabled=yes topics=radius
/system note set show-at-login=no
/system ntp client set enabled=yes
/system ntp server set enabled=yes
/system ntp client servers add address=10.1.1.2
/system ntp client servers add address=0.pool.ntp.org
/system ntp client servers add address=1.pool.ntp.org
/system ntp client servers add address=2.pool.ntp.org
/system ntp client servers add address=3.pool.ntp.org
/system routerboard settings set auto-upgrade=yes
/system scheduler add interval=5m name=dyndns-update on-event="/system/script/run dyndns-update" policy=ftp,read,write,policy,test start-date=2020-08-09 start-time=09:41:00
/system scheduler add name=init-onboot on-event="/system/script/run global-init-onboot\r\
    \n/system/script/run local-init-onboot\r\
    \n" policy=read,write,policy,test start-time=startup
/system scheduler add interval=1m name=wan-online-adjust on-event="/system/script/run wan-online-adjust\r\
    \n" policy=read,write,policy,test start-date=2023-01-17 start-time=19:51:50
/system scheduler add interval=1m name=container-autoheal on-event="/system/script/run container-autoheal\r\
    \n" policy=read,write,policy,test start-date=2023-12-02 start-time=07:56:27
/system scheduler add disabled=yes interval=1s name=keep-laser-awake on-event="/tool/wol mac=8C:16:45:46:05:22 interface=vlan-labnet\r\
    \n" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2024-07-18 start-time=00:03:44
/system script add dont-require-permissions=yes name=local-init-onboot owner=admin policy=read,write,policy,test source=":global VRRPPriorityOnline 25\r\
    \n:global VRRPPriorityOffline 5\r\
    \n\r\
    \n:global DynDNSHost \"router-backup.foxden.network\"\r\
    \n:global DynDNSKey \"REMOVED\"\r\
    \n\r\
    \n:global IPv6Host \"889575\"\r\
    \n:global IPv6Key \"REMOVED\"\r\
    \n\r\
    \n:global RAPriorityOnline \"medium\"\r\
    \n:global RAPriorityOffline \"low\"\r\
    \n"
/system script add dont-require-permissions=no name=dhcp-propagate-changes owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local topdomain\
    \n\
    \n:set topdomain \"foxden.network\"\
    \n\
    \n:put \"Adjusting lease times\"\
    \n/ip/dhcp-server/lease set [/ip/dhcp-server/lease find dynamic=no] lease-time=1d\
    \n\
    \n:put \"Appending zone file foxden.network\"\
    \n\
    \n:local loadscript \":put \\\"\\\\\\\$TTL 300\\\"\
    \n:put \\\"@ 3600 DS 56289 13 2 E0198538615845C4226057A4A9D3908FF76A054A49B76E72954D63BFCB88A257\\\"\
    \n:put \\\"@ 3600 DS 26212 13 2 9C50921B3FDB72B43A78713AF57E66D2BBA87C6CFDEC4FC2EA1320686B31FED4\\\"\
    \n:put \\\"@ IN NS ns1.foxden.network.\\\"\
    \n:put \\\"@ IN NS ns2.foxden.network.\\\"\
    \n:put \\\"@ IN NS ns3.foxden.network.\\\"\
    \n:put \\\"@ IN NS ns4.foxden.network.\\\"\
    \n:put \\\"ns1 IN A 10.3.0.53\\\"\
    \n:put \\\"ns2 IN A 10.3.0.53\\\"\
    \n:put \\\"ns3 IN A 10.3.0.53\\\"\
    \n:put \\\"ns4 IN A 10.3.0.53\\\"\
    \n:put \\\"nas IN CNAME bengalfox.foxden.network.\\\"\
    \n:put \\\"nas-ro IN A 10.99.12.5\\\"\
    \n:put \\\"@ IN A 10.99.12.4\\\"\
    \n:put \\\"xmpp IN A 10.99.12.4\\\"\
    \n:put \\\"upload.xmpp IN CNAME xmpp.foxden.network.\\\"\
    \n:put \\\"muc.xmpp IN CNAME xmpp.foxden.network.\\\"\
    \n:put \\\"proxy.xmpp IN CNAME xmpp.foxden.network.\\\"\
    \n:put \\\"pubsub.xmpp IN CNAME xmpp.foxden.network.\\\"\
    \n:put \\\"_xmpp-client._tcp IN SRV 5 0 5222 xmpp.foxden.network.\\\"\
    \n:put \\\"_xmpps-client._tcp SRV 5 0 5223 xmpp.foxden.network.\\\"\
    \n:put \\\"_xmpp-server._tcp SRV 5 0 5269 xmpp.foxden.network.\\\"\
    \n\
    \n:local hostshort\
    \n:local dhcpent\
    \n:foreach i in=[/ip/dhcp-server/lease/find comment dynamic=no] do={\
    \n    :set dhcpent [/ip/dhcp-server/lease/get \\\$i]\
    \n    :set hostshort (\\\$dhcpent->\\\"comment\\\")\
    \n\
    \n    :if (\\\$hostshort != \\\"ntp\\\" && \\\$hostshort != \\\"dns\\\" && \\\$hostshort != \\\"gateway\\\") do={\
    \n      :put (\\\$hostshort . \\\" IN A \\\" . (\\\$dhcpent->\\\"address\\\"))\
    \n    }\
    \n}\"\
    \n\
    \n:put \$loadscript\
    \n:execute script=\$loadscript file=foxdns-internal/foxden.network.txt\
    \n\
    \n:put \"Appending zone file 10.in-addr.arpa\"\
    \n\
    \n:local loadscript \":put \\\"\\\\\\\$TTL 300\\\"\
    \n:put \\\"@ IN NS ns1.foxden.network.\\\"\
    \n:put \\\"@ IN NS ns2.foxden.network.\\\"\
    \n:put \\\"@ IN NS ns3.foxden.network.\\\"\
    \n:put \\\"@ IN NS ns4.foxden.network.\\\"\
    \n:for i from=1 to=9 do={ \
    \n    :put \\\"1.0.\\\$i IN PTR gateway.foxden.network.\\\"\
    \n    :put \\\"53.0.\\\$i IN PTR dns.foxden.network.\\\"\
    \n    :put \\\"123.0.\\\$i IN PTR ntp.foxden.network.\\\"\
    \n    :put \\\"1.1.\\\$i IN PTR router.foxden.network.\\\"\
    \n    :put \\\"2.1.\\\$i IN PTR router-backup.foxden.network.\\\"\
    \n    :put \\\"123.1.\\\$i IN PTR ntpi.foxden.network.\\\"\
    \n}\
    \n:local hostname\
    \n:local hostshort\
    \n:local dhcpent\
    \n:local ipNum\
    \n:local reverseIpString\
    \n:foreach i in=[/ip/dhcp-server/lease/find comment dynamic=no] do={\
    \n    :set dhcpent [/ip/dhcp-server/lease/get \\\$i]\
    \n    :set hostshort (\\\$dhcpent->\\\"comment\\\")\
    \n\
    \n    :if (\\\$hostshort != \\\"ntp\\\" && \\\$hostshort != \\\"dns\\\" && \\\$hostshort != \\\"gateway\\\") do={\
    \n      :set hostname (\\\$hostshort . \\\".\$topdomain.\\\")\
    \n      :set ipNum [ :tonum [ :toip (\\\$dhcpent->\\\"address\\\") ] ]\
    \n      :set reverseIpString ((\\\$ipNum & 255) . \\\".\\\" . ((\\\$ipNum >> 8) & 255) . \\\".\\\" . ((\\\$ipNum >> 16) & 255))\
    \n      :put (\\\$reverseIpString . \\\" IN PTR \\\" . \\\$hostname)\
    \n    }\
    \n}\"\
    \n\
    \n:put \$loadscript\
    \n:execute script=\$loadscript file=foxdns-internal/10.in-addr.arpa.txt\
    \n\
    \n:put Done\
    \n"
/system script add dont-require-permissions=yes name=dyndns-update owner=admin policy=ftp,read,write,policy,test source=":local ipaddrfind [ /ip/address/find interface=wan ]\r\
    \n:if ([:len \$ipaddrfind] < 1) do={\r\
    \n    :log warning \"No WAN IP address found\"\r\
    \n    :exit\r\
    \n}\r\
    \n:local ipaddrcidr [/ip/address/get (\$ipaddrfind->0) address]\r\
    \n:local ipaddr [:pick \$ipaddrcidr 0 [:find \$ipaddrcidr \"/\"]]\r\
    \n:local isprimary [ /interface/vrrp/get vrrp-mgmt-gateway master ]\r\
    \n\r\
    \n/system/script/run firewall-update\r\
    \n\r\
    \n:global DynDNSHost\r\
    \n:global DynDNSKey\r\
    \n:global IPv6Host\r\
    \n:global IPv6Key\r\
    \n\r\
    \n:local dyndnsUpdate do={\r\
    \n    :global logputdebug\r\
    \n    :global logputinfo\r\
    \n    :global logputerror\r\
    \n\r\
    \n    \$logputdebug (\"[DynDNS] Beginning update of \". \$host)\r\
    \n    :if (\$dns!=\"\") do={\r\
    \n        :delay 1s\r\
    \n        :do {\r\
    \n            :local dnsip [:resolve \$host server=\$dns]\r\
    \n            if (\$dnsip=\$ipaddr) do={\r\
    \n                \$logputdebug (\"[DynDNS] No change in IP address for \" . \$host)\r\
    \n                :return \"\"\r\
    \n            }\r\
    \n        } on-error={\r\
    \n            \$logputerror (\"[DynDNS] Unable to resolve \" . \$host . \" using \" . \$dns)\r\
    \n            :return \"\"\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n    :delay 5s\r\
    \n\r\
    \n    :do {\r\
    \n        :if (\$nicUpdateMode=\"true\") do={\r\
    \n             :local result [/tool/fetch mode=\$mode http-auth-scheme=basic user=\"\$user\" password=\"\$key\" url=\"\$mode://\$updatehost/nic/update/\?hostname=\$host&myip=\$ipaddr\" as-value output=user]\r\
    \n             \$logputdebug (\"[DynDNS] Result of nic/update update for \". \$host . \": \" . (\$result->\"data\"))\r\
    \n        } else={\r\
    \n             :local result [/tool/fetch mode=\$mode http-auth-scheme=basic url=\"\$mode://\$updatehost/api/dynamicURL/\?q=\$key&ip=\$ipaddr&notify=1\" as-value output=user]\r\
    \n             \$logputdebug (\"[DynDNS] Result of api/dynamicURL update for \". \$host . \": \" . (\$result->\"data\"))\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        \$logputerror (\"[DynDNS] Unable to update \" . \$host)\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \nif (\$isprimary) do={\r\
    \n    \$dyndnsUpdate host=\"wan.foxden.network\" key=\"REMOVED\" updatehost=\"ipv4.cloudns.net\" dns=\"pns41.cloudns.net\" ipaddr=\$ipaddr mode=https\r\
    \n}\r\
    \n#\$dyndnsUpdate user=\"doridian\" host=\$IPv6Host key=\$IPv6Key updatehost=\"ipv4.tunnelbroker.net\" dns=\"\" ipaddr=\$ipaddr mode=https nicUpdateMode=true\r\
    \n#\$dyndnsUpdate host=\"redfoxv6\" key=(\"anonymous&primary=\" . \$isprimary) updatehost=\"10.99.10.1:9999\" dns=\"\" ipaddr=\$ipaddr mode=http\r\
    \n\$dyndnsUpdate host=\$DynDNSHost key=\$DynDNSKey updatehost=\"ipv4.cloudns.net\" dns=\"pns41.cloudns.net\" ipaddr=\$ipaddr mode=https\r\
    \n"
/system script add dont-require-permissions=no name=dhcp-mac-checker owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":local dhcpent\r\
    \n:local arpmac\r\
    \n:local arpfind\r\
    \n\r\
    \n:foreach i in=[/ip/dhcp-server/lease/find status!=bound dynamic=no] do={\r\
    \n    :set dhcpent [/ip/dhcp-server/lease/get \$i]\r\
    \n\r\
    \n    {\r\
    \n        :local jobID [:execute {:ping count=5 address=(\$dhcpent->\"address\")}]\r\
    \n        :while ([:len [/system/script/job/find .id=\$jobID]] > 0) do={\r\
    \n            :set arpfind [/ip/arp/find address=(\$dhcpent->\"address\") mac-address!=\"\"]\r\
    \n            if ([:len \$arpfind] > 0) do={\r\
    \n                :do { /system/script/job/remove \$jobID } on-error={}\r\
    \n            } else={\r\
    \n                :delay 1s\r\
    \n            }\r\
    \n        }\r\
    \n\r\
    \n        if ([:len \$arpfind] = 0) do={\r\
    \n            :set arpfind [/ip/arp/find address=(\$dhcpent->\"address\") mac-address!=\"\"]\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n    :set arpmac \"N/A\"\r\
    \n    :if ([:len \$arpfind] > 0) do={\r\
    \n        :set arpmac [/ip/arp/get (\$arpfind->0) mac-address]\r\
    \n    }\r\
    \n\r\
    \n    :if ([:typeof \$arpmac] = \"nil\" || \$arpmac = \"\") do={\r\
    \n        :set arpmac \"N/A\"\r\
    \n    }\r\
    \n\r\
    \n    :if (\$arpmac != (\$dhcpent->\"mac-address\")) do={\r\
    \n        :put (\"# IP: \" . (\$dhcpent->\"address\") . \" | DHCP MAC: \" . (\$dhcpent->\"mac-address\") . \" | ARP MAC: \" . \$arpmac . \" | Comment: \" . (\$dhcpent->\"comment\"))\r\
    \n        :if (\$arpmac != \"N/A\") do={\r\
    \n            :put (\"/ip/dhcp-server/lease set [/ip/dhcp-server/lease find address=\" . (\$dhcpent->\"address\") . \"] mac-address=\" . \$arpmac)\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=wan-online-adjust owner=admin policy=read,write,policy,test source=":global logputwarning\r\
    \n\r\
    \n:global VRRPPriorityOffline\r\
    \n:global VRRPPriorityOnline\r\
    \n:local VRRPPriorityCurrent \$VRRPPriorityOffline\r\
    \n\r\
    \n:global RAPriorityOffline\r\
    \n:global RAPriorityOnline\r\
    \n:local RAPriorityCurrent \$RAPriorityOffline\r\
    \n\r\
    \n/system/script/run firewall-update\r\
    \n\r\
    \nif ([/system/script/find name=local-maintenance-mode ]) do={\r\
    \n    \$logputwarning \"Maintenance mode ON\"\r\
    \n} else={\r\
    \n    :local defgwidx [ /ip/route/find dynamic active dst-address=0.0.0.0/0 ]\r\
    \n\r\
    \n    if ([:len \$defgwidx] > 0) do={\r\
    \n        :local defgw [ /ip/route/get (\$defgwidx->0) gateway ]\r\
    \n        :local status [ /tool/netwatch/get [ /tool/netwatch/find comment=\"monitor-default\" ] status ]\r\
    \n        if (\$status = \"up\") do={\r\
    \n            :set VRRPPriorityCurrent \$VRRPPriorityOnline\r\
    \n            :set RAPriorityCurrent \$RAPriorityOnline\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:put \"Set VRRP priority \$VRRPPriorityCurrent\"\r\
    \n/interface/vrrp/set [ /interface/vrrp/find priority!=\$VRRPPriorityCurrent ] priority=\$VRRPPriorityCurrent\r\
    \n\r\
    \n:put \"Set RA priority \$RAPriorityCurrent\"\r\
    \n/ipv6/nd/set [ /ipv6/nd/find ra-preference!=\$RAPriorityCurrent ] ra-preference=\$RAPriorityCurrent\r\
    \n"
/system script add dont-require-permissions=yes name=global-init-onboot owner=admin policy=read,write,policy,test source=":global logputdebug do={\r\
    \n    :log debug \$1\r\
    \n    :put \$1\r\
    \n}\r\
    \n:global logputinfo do={\r\
    \n    :log info \$1\r\
    \n    :put \$1\r\
    \n}\r\
    \n:global logputwarning do={\r\
    \n    :log warning \$1\r\
    \n    :put \$1\r\
    \n}\r\
    \n:global logputerror do={\r\
    \n    :log error \$1\r\
    \n    :put \$1\r\
    \n}\r\
    \n"
/system script add dont-require-permissions=yes name=firewall-update owner=admin policy=read,write,policy,test source=":local ipaddrfind [ /ip/address/find interface=wan ]\r\
    \n:if ([:len \$ipaddrfind] < 1) do={\r\
    \n    :log warning \"No WAN IP address found\"\r\
    \n    :exit\r\
    \n}\r\
    \n:local ipaddrcidr [/ip/address/get (\$ipaddrfind->0) address]\r\
    \n:local ipaddr [:pick \$ipaddrcidr 0 [:find \$ipaddrcidr \"/\"]]\r\
    \n\r\
    \n/ip/firewall/nat/set [ find comment=\"Hairpin\" dst-address!=\$ipaddr  ] dst-address=\$ipaddr\r\
    \n/ip/firewall/nat/set [ find comment=\"Hairpin fallback\" dst-address!=\"!\$ipaddr\" ] dst-address=\"!\$ipaddr\"\r\
    \n"
/system script add dont-require-permissions=no name=container-autoheal owner=admin policy=read,write,policy,test source=":global logputinfo\
    \n:global logputerror\
    \n\
    \n:local needrestart ([:len [/file/find name=container-restart-all]] > 0)\
    \n:local clearrestart \$needrestart\
    \n\
    \n\$logputinfo (\"Need restart = \$needrestart\")\
    \n\
    \n/container\
    \n:foreach ct in=[find] do={\
    \n  :local ctneedstop \$needrestart\
    \n  :if ([get \$ct status] != \"running\") do={\
    \n    :set ctneedstop true\
    \n  }\
    \n\
    \n  :if (\$ctneedstop) do={\
    \n    \$logputinfo (\"STOPPING container with interface \" . [get \$ct interface])\
    \n    stop \$ct\
    \n\
    \n    :local maxtries 50\
    \n    :while (\$maxtries > 0) do={\
    \n      :delay 100ms\
    \n      :set maxtries (\$maxtries - 1)\
    \n      :if ([get \$ct status] = \"stopped\") do={\
    \n        :set maxtries -999\
    \n      }\
    \n    }\
    \n    :if (\$maxtries != -999) do={\
    \n      \$logputerror (\"FAILED STOPPING container with interface \" . \$maxtries)\
    \n    } else={\
    \n      \$logputinfo (\"STOPPED container with interface \" . [get \$ct interface])\
    \n    }\
    \n  }\
    \n\
    \n  :if ([get \$ct status] = \"stopped\") do={\
    \n    \$logputinfo (\"STARTING container with interface \" . [get \$ct interface])\
    \n    start \$ct\
    \n  }\
    \n\
    \n  :local maxtries 50\
    \n  :while (\$maxtries > 0) do={\
    \n    :delay 100ms\
    \n    :set maxtries (\$maxtries - 1)\
    \n    :if ([get \$ct status] = \"running\") do={\
    \n      :set maxtries -999\
    \n    }\
    \n  }\
    \n  :if (\$maxtries != -999) do={\
    \n    \$logputerror (\"FAILED STARTING container with interface \" . \$maxtries)\
    \n    :set clearrestart false\
    \n  } else={\
    \n    \$logputinfo (\"STARTED container with interface \" . [get \$ct interface])\
    \n  }\
    \n}\
    \n\
    \n:if (\$clearrestart) do={\
    \n  /file/remove container-restart-all\
    \n  \$logputinfo (\"Cleared container-restart-all\")\
    \n}"
/system script add dont-require-permissions=no name=maintenance-on owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/system/script/add name=local-maintenance-mode source=\"# Maintenance mode is on\"\r\
    \n/system/script/run wan-online-adjust\r\
    \n"
/system script add dont-require-permissions=no name=maintenance-off owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/system/script/remove local-maintenance-mode\r\
    \n/system/script/run wan-online-adjust\r\
    \n"
/system script add dont-require-permissions=yes name=fetch-intermediates owner=admin policy=ftp,read,write,policy,test,sensitive source=":local res [/tool/fetch url=\"https://letsencrypt.org/certificates/\" as-value output=user]\r\
    \n:local certificates (\$res->\"data\")\r\
    \n\r\
    \n:do {\r\
    \n    :local nextlinkbegin [:find \$certificates \"<a href=\\\"\" 0]\r\
    \n    :if (\$nextlinkbegin < 0) do={\r\
    \n        :put \"No more links found\"\r\
    \n        :set certificates \"\"\r\
    \n    } else={\r\
    \n        :local nextlinkend [:find \$certificates \"\\\">\" \$nextlinkbegin]\r\
    \n        :local nextlink [:pick \$certificates (\$nextlinkbegin + 9) \$nextlinkend]\r\
    \n        :set certificates [:pick \$certificates \$nextlinkend [:len \$certificates]]\r\
    \n\r\
    \n        # Minimal URL path resolver...\r\
    \n        :if ([:pick \$nextlink 0 1] = \"/\") do={\r\
    \n            :set nextlink (\"https://letsencrypt.org\" . \$nextlink)\r\
    \n        } else={\r\
    \n            :if ([:find \$nextlink \"://\" 0] < 0) do={\r\
    \n                :set nextlink (\"https://letsencrypt.org/certificates/\" . \$nextlink)\r\
    \n            }\r\
    \n        }\r\
    \n\r\
    \n        :if ([:pick \$nextlink ([:len \$nextlink] - 4) [:len \$nextlink]] = \".pem\") do={\r\
    \n            :if ([:find \$nextlink \"-cross\" 0] < 0) do={\r\
    \n                :if ([:find \$nextlink \"/letsencryptauthorityx\" 0] < 0) do={\r\
    \n                    :local foundcerts [/certificate/find name=\$nextlink]\r\
    \n                    :if ([:len \$foundcerts] = 0) do={\r\
    \n                        :put \"Downloading \$nextlink\"\r\
    \n                        :do {\r\
    \n                            /file/remove tmpfs-scratch/intermediates-cert.pem\r\
    \n                            :delay 1s\r\
    \n                        } on-error={}\r\
    \n                        /tool/fetch url=\$nextlink dst-path=tmpfs-scratch/intermediates-cert.pem\r\
    \n                        :delay 1s\r\
    \n                        /certificate/import file-name=tmpfs-scratch/intermediates-cert.pem name=\$nextlink trusted=yes\r\
    \n                        :delay 1s\r\
    \n                    } else={\r\
    \n                        :put \"Skipping already downloaded \$nextlink\"\r\
    \n                    }\r\
    \n                } else={\r\
    \n                    :put \"Skipping obsolete letsencryptauthorityx# certificate \$nextlink\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :put \"Skipping cross-signed certificate \$nextlink\"\r\
    \n            }\r\
    \n        }\r\
    \n    }\r\
    \n} while ([:len \$certificates] > 0)\r\
    \n"
/tool netwatch add comment=monitor-default disabled=no down-script="/system/script/run wan-online-adjust\r\
    \n" host=8.8.8.8 http-codes="" interval=30s startup-delay=1m test-script="" timeout=1s type=icmp up-script="/system/script/run wan-online-adjust\r\
    \n"
/user aaa set accounting=no use-radius=yes
