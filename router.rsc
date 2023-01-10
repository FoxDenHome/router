# jan/10/2023 00:56:49 by RouterOS 7.6
# software id = REMOVED
#
# model = CCR2004-1G-12S+2XS
# serial number = REMOVED
/interface ethernet
set [ find default-name=ether1 ] name=eth1-oob
set [ find default-name=sfp-sfpplus1 ] advertise=\
    1000M-full,10000M-full,2500M-full,5000M-full name=sfp1-wan \
    rx-flow-control=on speed=10Gbps tx-flow-control=on
set [ find default-name=sfp-sfpplus2 ] auto-negotiation=no disabled=yes \
    l2mtu=9088 mtu=9000 name=sfp2 speed=10Gbps
set [ find default-name=sfp-sfpplus3 ] disabled=yes name=sfp3
set [ find default-name=sfp-sfpplus4 ] disabled=yes name=sfp4
set [ find default-name=sfp-sfpplus5 ] disabled=yes name=sfp5
set [ find default-name=sfp-sfpplus6 ] disabled=yes name=sfp6
set [ find default-name=sfp-sfpplus7 ] disabled=yes name=sfp7
set [ find default-name=sfp-sfpplus8 ] disabled=yes name=sfp8
set [ find default-name=sfp-sfpplus9 ] disabled=yes name=sfp9
set [ find default-name=sfp-sfpplus10 ] disabled=yes name=sfp10
set [ find default-name=sfp-sfpplus11 ] disabled=yes name=sfp11
set [ find default-name=sfp-sfpplus12 ] disabled=yes name=sfp12
set [ find default-name=sfp28-1 ] advertise=10M-half auto-negotiation=no \
    disabled=yes fec-mode=fec74 l2mtu=9092 mtu=9000 name=sfpx1 speed=25Gbps
set [ find default-name=sfp28-2 ] auto-negotiation=no fec-mode=fec74 l2mtu=\
    9092 mtu=9000 name=sfpx2-rackswitch-agg speed=25Gbps
/interface 6to4
add !keepalive name=6to4-redfox remote-address=66.42.71.230
/interface vrrp
add interface=sfpx2-rackswitch-agg mtu=9000 name=vrrp-mgmt-dns priority=50 \
    version=2 vrid=53
add interface=sfpx2-rackswitch-agg mtu=9000 name=vrrp-mgmt-gateway priority=\
    50 version=2
add interface=sfpx2-rackswitch-agg mtu=9000 name=vrrp-mgmt-ntp priority=50 \
    version=2 vrid=123
/interface wireguard
add listen-port=13232 mtu=1420 name=wg-s2s
add listen-port=13231 mtu=1420 name=wg-vpn
/interface vlan
add interface=sfpx2-rackswitch-agg mtu=9000 name=vlan-dmz vlan-id=3
add interface=sfpx2-rackswitch-agg mtu=9000 name=vlan-hypervisor vlan-id=6
add interface=sfpx2-rackswitch-agg mtu=9000 name=vlan-labnet vlan-id=4
add interface=sfpx2-rackswitch-agg mtu=9000 name=vlan-lan vlan-id=2
add interface=sfpx2-rackswitch-agg mtu=9000 name=vlan-security vlan-id=5
/interface vrrp
add interface=vlan-dmz mtu=9000 name=vrrp-dmz-dns priority=50 version=2 vrid=\
    53
add interface=vlan-dmz mtu=9000 name=vrrp-dmz-gateway priority=50 version=2
add interface=vlan-dmz mtu=9000 name=vrrp-dmz-ntp priority=50 version=2 vrid=\
    123
add interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-dns priority=50 \
    version=2 vrid=53
add interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-gateway priority=\
    50 version=2
add interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-ntp priority=50 \
    version=2 vrid=123
add interface=vlan-labnet mtu=9000 name=vrrp-labnet-dns priority=50 version=2 \
    vrid=53
add interface=vlan-labnet mtu=9000 name=vrrp-labnet-gateway priority=50 \
    version=2
add interface=vlan-labnet mtu=9000 name=vrrp-labnet-ntp priority=50 version=2 \
    vrid=123
add interface=vlan-lan mtu=9000 name=vrrp-lan-dns priority=50 version=2 vrid=\
    53
add interface=vlan-lan mtu=9000 name=vrrp-lan-gateway priority=50 version=2
add interface=vlan-lan mtu=9000 name=vrrp-lan-ntp priority=50 version=2 vrid=\
    123
add interface=vlan-security mtu=9000 name=vrrp-security-dns priority=50 \
    version=2 vrid=53
add interface=vlan-security mtu=9000 name=vrrp-security-gateway priority=50 \
    version=2
add interface=vlan-security mtu=9000 name=vrrp-security-ntp priority=50 \
    version=2 vrid=123
/interface list
add name=iface-mgmt
add name=iface-lan
add name=iface-dmz
add name=iface-labnet
add name=iface-security
add name=iface-hypervisor
add include="iface-dmz,iface-hypervisor,iface-labnet,iface-lan,iface-mgmt,ifac\
    e-security" name=zone-local
add name=zone-wan
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server option
add code=121 name=classless value=\
    "'8''10'\$(NETWORK_GATEWAY)'0'\$(NETWORK_GATEWAY)"
/ip dhcp-server option sets
add name=default-classless options=classless
add name=nothing
add name=default-noclassless
/ip pool
add name=pool-mgmt ranges=10.1.100.0-10.1.200.255
add name=pool-lan ranges=10.2.100.0-10.2.200.255
add name=pool-dmz ranges=10.3.100.0-10.3.200.255
add name=pool-labnet ranges=10.4.100.0-10.4.200.255
add name=pool-security ranges=10.5.100.0-10.5.200.255
add name=pool-hypervisor ranges=10.6.100.0-10.6.200.255
add name=pool-oob ranges=192.168.88.100-192.168.88.200
/ip dhcp-server
add address-pool=pool-labnet dhcp-option-set=default-classless interface=\
    vlan-labnet lease-time=1h name=dhcp-labnet
add address-pool=pool-lan dhcp-option-set=default-classless interface=\
    vlan-lan lease-time=1h name=dhcp-lan
add address-pool=pool-dmz dhcp-option-set=default-classless interface=\
    vlan-dmz lease-time=1h name=dhcp-dmz
add address-pool=pool-mgmt dhcp-option-set=default-classless interface=\
    sfpx2-rackswitch-agg lease-time=1h name=dhcp-mgmt
add address-pool=pool-security dhcp-option-set=default-classless interface=\
    vlan-security lease-time=1h name=dhcp-security
add address-pool=pool-hypervisor dhcp-option-set=default-classless interface=\
    vlan-hypervisor lease-time=1h name=dhcp-hypervisor
add address-pool=pool-oob bootp-support=none interface=eth1-oob lease-time=1h \
    name=dhcp-oob
/port
set 0 name=serial0
set 1 name=serial1
/queue type
add cake-nat=yes cake-rtt-scheme=internet kind=cake name=cake-internet
/queue simple
add disabled=yes max-limit=950M/950M name=queue-wan queue=\
    cake-internet/cake-internet target=sfp1-wan
/snmp community
set [ find default=yes ] disabled=yes
add addresses=::/0 name=monitor_REMOVED
/ip settings
set rp-filter=loose tcp-syncookies=yes
/ipv6 settings
set accept-redirects=no accept-router-advertisements=no
/interface list member
add interface=sfpx2-rackswitch-agg list=iface-mgmt
add interface=vrrp-mgmt-gateway list=iface-mgmt
add interface=vrrp-mgmt-dns list=iface-mgmt
add interface=vrrp-mgmt-ntp list=iface-mgmt
add interface=vlan-lan list=iface-lan
add interface=vrrp-lan-gateway list=iface-lan
add interface=vrrp-lan-dns list=iface-lan
add interface=vrrp-lan-ntp list=iface-lan
add interface=vlan-dmz list=iface-dmz
add interface=vrrp-dmz-gateway list=iface-dmz
add interface=vrrp-dmz-dns list=iface-dmz
add interface=vrrp-dmz-ntp list=iface-dmz
add interface=vlan-labnet list=iface-labnet
add interface=vrrp-labnet-gateway list=iface-labnet
add interface=vrrp-labnet-dns list=iface-labnet
add interface=vrrp-labnet-ntp list=iface-labnet
add interface=vlan-security list=iface-security
add interface=vrrp-security-gateway list=iface-security
add interface=vrrp-security-dns list=iface-security
add interface=vrrp-security-ntp list=iface-security
add interface=vlan-hypervisor list=iface-hypervisor
add interface=vrrp-hypervisor-gateway list=iface-hypervisor
add interface=vrrp-hypervisor-dns list=iface-hypervisor
add interface=vrrp-hypervisor-ntp list=iface-hypervisor
add interface=6to4-redfox list=zone-wan
add interface=sfp1-wan list=zone-wan
add interface=wg-s2s list=zone-local
add interface=wg-vpn list=zone-local
/interface wireguard peers
add allowed-address=10.100.10.1/32 comment=Fennec interface=wg-vpn \
    public-key="+23L+00o9c/O+9UaFp5mxCNMldExLtkngk3cjIIKXzY="
add allowed-address=10.100.10.2/32 comment=CapeFox interface=wg-vpn \
    public-key="jay5WNfSd0Wo5k+FMweulWnaoxm1I82gom7JNkEjUBs="
add allowed-address=10.100.10.3/32 comment="Dori Phone" interface=wg-vpn \
    public-key="keEyvK/AutdYbAYkkXffsvGEOCKZjlp6A0gDBsI8F0g="
add allowed-address=10.100.10.4/32 comment="Wizzy Laptop" interface=wg-vpn \
    public-key="5QUN5FumE8LM1Ak9tv8gwaF8K4wTXlCw2BSDfBIEL3g="
add allowed-address=10.99.10.1/32 comment=RedFox endpoint-address=\
    66.42.71.230 endpoint-port=13232 interface=wg-s2s persistent-keepalive=\
    25s public-key="yY6nKPCqcj+0O6Sm7qcBlG7O5tyQlarlZFIKjp+ivGM="
add allowed-address=10.99.10.2/32 comment=IceFox endpoint-address=\
    116.202.171.116 endpoint-port=13232 interface=wg-s2s \
    persistent-keepalive=25s public-key=\
    "t4vx8Lz7TNazvwid9I3jtbowkfb8oNM4TpdttEIUjRs="
/ip address
add address=10.1.1.1/16 interface=sfpx2-rackswitch-agg network=10.1.0.0
add address=10.2.1.1/16 interface=vlan-lan network=10.2.0.0
add address=10.3.1.1/16 interface=vlan-dmz network=10.3.0.0
add address=10.4.1.1/16 interface=vlan-labnet network=10.4.0.0
add address=10.5.1.1/16 interface=vlan-security network=10.5.0.0
add address=10.6.1.1/16 interface=vlan-hypervisor network=10.6.0.0
add address=192.168.88.1/24 interface=eth1-oob network=192.168.88.0
add address=10.1.0.1 interface=vrrp-mgmt-gateway network=10.1.0.1
add address=10.1.0.123 interface=vrrp-mgmt-ntp network=10.1.0.123
add address=10.1.0.53 interface=vrrp-mgmt-dns network=10.1.0.53
add address=10.2.0.1 interface=vrrp-lan-gateway network=10.2.0.1
add address=10.2.0.123 interface=vrrp-lan-ntp network=10.2.0.123
add address=10.2.0.53 interface=vrrp-lan-dns network=10.2.0.53
add address=10.3.0.1 interface=vrrp-dmz-gateway network=10.3.0.1
add address=10.3.0.123 interface=vrrp-dmz-ntp network=10.3.0.123
add address=10.3.0.53 interface=vrrp-dmz-dns network=10.3.0.53
add address=10.4.0.1 interface=vrrp-labnet-gateway network=10.4.0.1
add address=10.4.0.123 interface=vrrp-labnet-ntp network=10.4.0.123
add address=10.4.0.53 interface=vrrp-labnet-dns network=10.4.0.53
add address=10.5.0.1 interface=vrrp-security-gateway network=10.5.0.1
add address=10.5.0.123 interface=vrrp-security-ntp network=10.5.0.123
add address=10.5.0.53 interface=vrrp-security-dns network=10.5.0.53
add address=10.6.0.1 interface=vrrp-hypervisor-gateway network=10.6.0.1
add address=10.6.0.123 interface=vrrp-hypervisor-ntp network=10.6.0.123
add address=10.6.0.53 interface=vrrp-hypervisor-dns network=10.6.0.53
add address=10.100.0.1/16 interface=wg-vpn network=10.100.0.0
add address=10.99.0.1/16 interface=wg-s2s network=10.99.0.0
/ip cloud
set update-time=no
/ip dhcp-client
add default-route-distance=5 interface=sfp1-wan use-peer-dns=no use-peer-ntp=\
    no
/ip dhcp-server lease
add address=1.2.3.4 comment=test lease-time=10h mac-address=00:00:00:00:00:01 \
    server=dhcp-dmz
add address=10.2.10.3 comment=capefox lease-time=1d mac-address=\
    F0:2F:4B:14:84:F4 server=dhcp-lan
add address=10.6.10.2 comment=islandfox lease-time=1d mac-address=\
    B8:AE:ED:7C:1E:71 server=dhcp-hypervisor
add address=10.2.10.1 comment=fennec lease-time=1d mac-address=\
    00:02:C9:23:3C:E0 server=dhcp-lan
add address=10.2.11.1 comment=nas lease-time=1d mac-address=00:0C:29:C6:9A:DC \
    server=dhcp-lan
add address=10.2.10.2 comment=wizzy-desktop lease-time=1d mac-address=\
    EC:0D:9A:21:DF:70 server=dhcp-lan
add address=10.1.12.1 comment=nas-ipmi lease-time=1d mac-address=\
    00:25:90:6D:05:12 server=dhcp-mgmt
add address=10.1.10.4 comment=switch-living-room lease-time=1d mac-address=\
    80:2A:A8:DE:F0:AE server=dhcp-mgmt
add address=10.1.11.1 comment=pdu-rack lease-time=1d mac-address=\
    00:06:67:41:F2:78 server=dhcp-mgmt
add address=10.1.10.2 comment=switch-rack lease-time=1d mac-address=\
    24:5A:4C:A6:6B:9A server=dhcp-mgmt
add address=10.1.10.3 comment=switch-rack-agg lease-time=1d mac-address=\
    24:5A:4C:56:41:C4 server=dhcp-mgmt
add address=10.1.11.2 comment=ups-rack lease-time=1d mac-address=\
    00:C0:B7:E8:B2:A0 server=dhcp-mgmt
add address=10.1.10.1 comment=unifi lease-time=1d mac-address=\
    24:5A:4C:8A:23:3F server=dhcp-mgmt
add address=10.1.10.7 comment=ap-living-room lease-time=1d mac-address=\
    60:22:32:1D:48:15 server=dhcp-mgmt
add address=10.1.10.6 comment=ap-server-room lease-time=1d mac-address=\
    68:D7:9A:1F:57:E2 server=dhcp-mgmt
add address=10.1.10.5 comment=switch-workbench lease-time=1d mac-address=\
    74:83:C2:FF:87:16 server=dhcp-mgmt
add address=10.1.10.10 comment=switch-dori-office lease-time=1d mac-address=\
    60:22:32:39:77:9C server=dhcp-mgmt
add address=10.1.10.8 comment=switch-dori-office-10g lease-time=1d \
    mac-address=18:FD:74:7B:0C:B9 server=dhcp-mgmt
add address=10.6.11.2 comment=telegraf lease-time=1d mac-address=\
    00:50:56:2E:16:A0 server=dhcp-hypervisor
add address=10.2.11.2 comment=syncthing lease-time=1d mac-address=\
    02:42:C0:A8:04:15 server=dhcp-lan
add address=10.1.11.3 comment=ups-dori-office lease-time=1d mac-address=\
    00:0C:15:04:39:93 server=dhcp-mgmt
add address=10.2.12.3 comment=printer lease-time=1d mac-address=\
    E8:D8:D1:79:F5:98 server=dhcp-lan
add address=10.2.12.1 comment=hue lease-time=1d mac-address=00:17:88:AC:31:4B \
    server=dhcp-lan
add address=10.2.12.2 comment=homeassistant lease-time=1d mac-address=\
    52:54:00:92:B1:80 server=dhcp-lan
add address=10.5.11.2 comment=camera-living-room lease-time=1d mac-address=\
    68:D7:9A:CF:30:09 server=dhcp-security
add address=10.2.11.3 comment=plex lease-time=1d mac-address=\
    02:42:C0:A8:04:16 server=dhcp-lan
add address=10.6.11.1 comment=prometheus lease-time=1d mac-address=\
    02:42:C0:A8:04:17 server=dhcp-hypervisor
add address=10.2.11.5 comment=grafana lease-time=1d mac-address=\
    02:42:C0:A8:04:18 server=dhcp-lan
add address=10.2.11.6 comment=kiwix lease-time=1d mac-address=\
    02:42:C0:A8:04:19 server=dhcp-lan
add address=10.2.11.8 comment=dldr lease-time=1d mac-address=\
    02:42:C0:A8:04:20 server=dhcp-lan
add address=10.2.12.7 comment=clock-nixie-zen lease-time=1d mac-address=\
    E0:4F:43:C2:BA:C2 server=dhcp-lan
add address=10.2.13.7 comment=airgradient-bedroom lease-time=1d mac-address=\
    AC:0B:FB:D0:34:B7 server=dhcp-lan
add address=10.2.13.6 comment=airgradient-living-room lease-time=1d \
    mac-address=AC:0B:FB:D0:7B:5B server=dhcp-lan
add address=10.2.13.5 comment=airgradient-dori-office lease-time=1d \
    mac-address=94:B5:55:2D:78:08 server=dhcp-lan
add address=10.2.12.9 comment=vacuum-neato lease-time=1d mac-address=\
    40:BD:32:95:26:C0 server=dhcp-lan
add address=10.2.12.4 comment=homepod-living-room lease-time=1d mac-address=\
    F4:34:F0:4B:87:1A server=dhcp-lan
add address=10.2.12.5 comment=homepod-bedroom lease-time=1d mac-address=\
    94:EA:32:84:DB:90 server=dhcp-lan
add address=10.2.14.1 comment=dori-phone lease-time=1d mac-address=\
    3A:AF:A8:F3:A6:F5 server=dhcp-lan
add address=10.2.12.6 comment=appletv-living-room lease-time=1d mac-address=\
    58:D3:49:E4:02:2D server=dhcp-lan
add address=10.2.15.1 comment=nintendo-switch-wired lease-time=1d \
    mac-address=00:0E:C6:D2:C9:DD server=dhcp-lan
add address=10.2.14.3 comment=wizzy-phone lease-time=1d mac-address=\
    56:6C:5E:7A:0E:C7 server=dhcp-lan
add address=10.2.14.4 comment=wizzy-watch lease-time=1d mac-address=\
    2E:47:59:D7:CF:2D server=dhcp-lan
add address=10.2.10.6 comment=wizzy-laptop-2 lease-time=1d mac-address=\
    88:66:5A:53:5E:40 server=dhcp-lan
add address=10.2.10.5 comment=wizzy-laptop lease-time=1d mac-address=\
    F0:2F:4B:15:2E:54 server=dhcp-lan
add address=10.2.12.10 comment=amp-living-room lease-time=1d mac-address=\
    EC:F4:51:D0:8C:AF server=dhcp-lan
add address=10.2.12.8 comment=clock-nixie-dori lease-time=1d mac-address=\
    C4:5B:BE:63:3A:2E server=dhcp-lan
add address=10.2.14.2 comment=dori-watch lease-time=1d mac-address=\
    EA:49:8F:A3:91:E5 server=dhcp-lan
add address=10.3.10.5 comment=spaceage-web lease-time=1d mac-address=\
    00:16:3E:CA:7E:30 server=dhcp-dmz
add address=10.3.10.4 comment=spaceage-gmod lease-time=1d mac-address=\
    00:16:3E:CA:7E:31 server=dhcp-dmz
add address=10.3.10.1 comment=foxcaves lease-time=1d mac-address=\
    00:16:3E:CA:7E:00 server=dhcp-dmz
add address=10.2.13.4 comment=sonoff-s31-lighthouse-bl lease-time=1d \
    mac-address=8C:AA:B5:66:3B:BE server=dhcp-lan
add address=10.2.13.3 comment=sonoff-s31-bambu-x1 lease-time=1d mac-address=\
    E8:DB:84:9F:4F:08 server=dhcp-lan
add address=10.2.13.8 comment=sonoff-s31-dori-pc lease-time=1d mac-address=\
    8C:AA:B5:66:3D:81 server=dhcp-lan
add address=10.2.13.2 comment=sonoff-s31-dori-office-fan lease-time=1d \
    mac-address=8C:AA:B5:66:12:00 server=dhcp-lan
add address=10.2.13.1 comment=sonoff-s31-wizzy-pc lease-time=1d mac-address=\
    8C:AA:B5:66:10:70 server=dhcp-lan
add address=10.3.10.3 comment=ut2004 lease-time=1d mac-address=\
    00:16:3E:CA:7E:02 server=dhcp-dmz
add address=10.2.13.10 comment=custom-dori-office-desk lease-time=1d \
    mac-address=84:F7:03:73:A0:FC server=dhcp-lan
add address=10.2.13.12 comment=sonoff-s31-lighthouse-br lease-time=1d \
    mac-address=C4:5B:BE:E4:9B:00 server=dhcp-lan
add address=10.3.10.7 comment=factorio lease-time=1d mac-address=\
    00:16:3E:CA:7E:06 server=dhcp-dmz
add address=10.2.13.11 comment=uplift-wizzy-desk lease-time=1d mac-address=\
    40:91:51:52:11:F7 server=dhcp-lan
add address=10.6.12.1 comment=islandfox-ipmi lease-time=1d mac-address=\
    04:7B:CB:44:C0:DD server=dhcp-hypervisor
add address=10.2.10.4 comment=capefox-wired lease-time=1d mac-address=\
    00:30:93:12:12:38 server=dhcp-lan
add address=10.2.12.11 comment=homepod-dori lease-time=1d mac-address=\
    04:99:B9:66:DE:D0 server=dhcp-lan
add address=10.2.12.12 comment=august-connect lease-time=1d mac-address=\
    D8:61:62:12:6A:08 server=dhcp-lan
add address=10.2.12.13 comment=homepod-den lease-time=1d mac-address=\
    04:99:B9:9E:9B:95 server=dhcp-lan
add address=10.5.11.1 comment=camera-front-door lease-time=1d mac-address=\
    D0:21:F9:94:97:13 server=dhcp-security
add address=10.1.10.9 comment=switch-dori-office lease-time=1d mac-address=\
    F4:92:BF:A3:E8:E8 server=dhcp-mgmt
add address=10.2.12.14 comment=homepod-wizzy lease-time=1d mac-address=\
    04:99:B9:79:EE:C9 server=dhcp-lan
add address=10.2.12.15 comment=tesla-model-3 lease-time=1d mac-address=\
    CC:88:26:27:41:29 server=dhcp-lan
add address=10.2.12.16 comment=tesla-wall-charger lease-time=1d mac-address=\
    98:ED:5C:9B:79:CF server=dhcp-lan
add address=10.2.13.14 comment=sonoff-s31-valve-index lease-time=1d \
    mac-address=C4:5B:BE:E4:9B:6B server=dhcp-lan
add address=10.2.13.13 comment=sonoff-s31-lighthouse-fl lease-time=1d \
    mac-address=C4:5B:BE:E4:82:69 server=dhcp-lan
add address=10.5.10.1 comment=nvr lease-time=1d mac-address=60:22:32:F1:BF:71 \
    server=dhcp-security
add address=10.4.10.1 comment=bambu-x1 lease-time=1d mac-address=\
    08:FB:EA:02:64:96 server=dhcp-labnet
/ip dhcp-server network
add address=10.1.0.0/16 dns-server=10.1.0.53 domain=foxden.network gateway=\
    10.1.0.1 netmask=16 ntp-server=10.1.0.123
add address=10.2.0.0/16 dns-server=10.2.0.53 domain=foxden.network gateway=\
    10.2.0.1 netmask=16 ntp-server=10.2.0.123
add address=10.3.0.0/16 dns-server=10.3.0.53 domain=foxden.network gateway=\
    10.3.0.1 netmask=16 ntp-server=10.3.0.123
add address=10.4.0.0/16 dns-server=10.4.0.53 domain=foxden.network gateway=\
    10.4.0.1 netmask=16 ntp-server=10.4.0.123
add address=10.5.0.0/16 dns-server=10.5.0.53 domain=foxden.network gateway=\
    10.5.0.1 netmask=16 ntp-server=10.5.0.123
add address=10.6.0.0/16 dns-server=10.6.0.53 domain=foxden.network gateway=\
    10.6.0.1 netmask=16 ntp-server=10.6.0.123
/ip dns
set allow-remote-requests=yes cache-size=20480KiB servers=8.8.8.8,8.8.4.4 \
    use-doh-server=https://dns.google/dns-query verify-doh-cert=yes
/ip dns static
add address=10.2.0.1 name=router.foxden.network
add address=::ffff:10.2.0.1 name=router.foxden.network type=AAAA
add address=10.2.1.1 name=vpn.foxden.network
add address=::ffff:10.2.1.1 name=vpn.foxden.network type=AAAA
add address=10.2.10.3 name=capefox.foxden.network
add address=::ffff:10.2.10.3 name=capefox.foxden.network type=AAAA
add address=10.6.10.2 name=islandfox.foxden.network
add address=::ffff:10.6.10.2 name=islandfox.foxden.network type=AAAA
add address=10.2.10.1 name=fennec.foxden.network
add address=::ffff:10.2.10.1 name=fennec.foxden.network type=AAAA
add address=10.2.11.1 name=nas.foxden.network
add address=::ffff:10.2.11.1 name=nas.foxden.network type=AAAA
add address=10.2.10.2 name=wizzy-desktop.foxden.network
add address=::ffff:10.2.10.2 name=wizzy-desktop.foxden.network type=AAAA
add address=10.1.12.1 name=nas-ipmi.foxden.network
add address=::ffff:10.1.12.1 name=nas-ipmi.foxden.network type=AAAA
add address=10.1.10.4 name=switch-living-room.foxden.network
add address=::ffff:10.1.10.4 name=switch-living-room.foxden.network type=AAAA
add address=10.1.11.1 name=pdu-rack.foxden.network
add address=::ffff:10.1.11.1 name=pdu-rack.foxden.network type=AAAA
add address=10.1.10.2 name=switch-rack.foxden.network
add address=::ffff:10.1.10.2 name=switch-rack.foxden.network type=AAAA
add address=10.1.10.3 name=switch-rack-agg.foxden.network
add address=::ffff:10.1.10.3 name=switch-rack-agg.foxden.network type=AAAA
add address=10.1.11.2 name=ups-rack.foxden.network
add address=::ffff:10.1.11.2 name=ups-rack.foxden.network type=AAAA
add address=10.1.10.1 name=unifi.foxden.network
add address=::ffff:10.1.10.1 name=unifi.foxden.network type=AAAA
add address=10.1.10.7 name=ap-living-room.foxden.network
add address=::ffff:10.1.10.7 name=ap-living-room.foxden.network type=AAAA
add address=10.1.10.6 name=ap-server-room.foxden.network
add address=::ffff:10.1.10.6 name=ap-server-room.foxden.network type=AAAA
add address=10.1.10.5 name=switch-workbench.foxden.network
add address=::ffff:10.1.10.5 name=switch-workbench.foxden.network type=AAAA
add address=10.1.10.8 name=switch-dori-office-10g.foxden.network
add address=::ffff:10.1.10.8 name=switch-dori-office-10g.foxden.network type=\
    AAAA
add address=10.6.11.2 name=telegraf.foxden.network
add address=::ffff:10.6.11.2 name=telegraf.foxden.network type=AAAA
add address=10.2.11.2 name=syncthing.foxden.network
add address=::ffff:10.2.11.2 name=syncthing.foxden.network type=AAAA
add address=10.1.11.3 name=ups-dori-office.foxden.network
add address=::ffff:10.1.11.3 name=ups-dori-office.foxden.network type=AAAA
add address=10.2.12.3 name=printer.foxden.network
add address=::ffff:10.2.12.3 name=printer.foxden.network type=AAAA
add address=10.2.12.1 name=hue.foxden.network
add address=::ffff:10.2.12.1 name=hue.foxden.network type=AAAA
add address=10.2.12.2 name=homeassistant.foxden.network
add address=::ffff:10.2.12.2 name=homeassistant.foxden.network type=AAAA
add address=10.5.11.2 name=camera-living-room.foxden.network
add address=::ffff:10.5.11.2 name=camera-living-room.foxden.network type=AAAA
add address=10.2.11.3 name=plex.foxden.network
add address=::ffff:10.2.11.3 name=plex.foxden.network type=AAAA
add address=10.6.11.1 name=prometheus.foxden.network
add address=::ffff:10.6.11.1 name=prometheus.foxden.network type=AAAA
add address=10.2.11.5 name=grafana.foxden.network
add address=::ffff:10.2.11.5 name=grafana.foxden.network type=AAAA
add address=10.2.11.6 name=kiwix.foxden.network
add address=::ffff:10.2.11.6 name=kiwix.foxden.network type=AAAA
add address=10.2.11.8 name=dldr.foxden.network
add address=::ffff:10.2.11.8 name=dldr.foxden.network type=AAAA
add address=10.2.12.7 name=clock-nixie-zen.foxden.network
add address=::ffff:10.2.12.7 name=clock-nixie-zen.foxden.network type=AAAA
add address=10.2.13.7 name=airgradient-bedroom.foxden.network
add address=::ffff:10.2.13.7 name=airgradient-bedroom.foxden.network type=\
    AAAA
add address=10.2.13.6 name=airgradient-living-room.foxden.network
add address=::ffff:10.2.13.6 name=airgradient-living-room.foxden.network \
    type=AAAA
add address=10.2.13.5 name=airgradient-dori-office.foxden.network
add address=::ffff:10.2.13.5 name=airgradient-dori-office.foxden.network \
    type=AAAA
add address=10.2.12.9 name=vacuum-neato.foxden.network
add address=::ffff:10.2.12.9 name=vacuum-neato.foxden.network type=AAAA
add address=10.2.12.4 name=homepod-living-room.foxden.network
add address=::ffff:10.2.12.4 name=homepod-living-room.foxden.network type=\
    AAAA
add address=10.2.12.5 name=homepod-bedroom.foxden.network
add address=::ffff:10.2.12.5 name=homepod-bedroom.foxden.network type=AAAA
add address=10.2.14.1 name=dori-phone.foxden.network
add address=::ffff:10.2.14.1 name=dori-phone.foxden.network type=AAAA
add address=10.2.12.6 name=appletv-living-room.foxden.network
add address=::ffff:10.2.12.6 name=appletv-living-room.foxden.network type=\
    AAAA
add address=10.2.15.1 name=nintendo-switch-wired.foxden.network
add address=::ffff:10.2.15.1 name=nintendo-switch-wired.foxden.network type=\
    AAAA
add address=10.2.14.3 name=wizzy-phone.foxden.network
add address=::ffff:10.2.14.3 name=wizzy-phone.foxden.network type=AAAA
add address=10.2.14.4 name=wizzy-watch.foxden.network
add address=::ffff:10.2.14.4 name=wizzy-watch.foxden.network type=AAAA
add address=10.2.10.6 name=wizzy-laptop-2.foxden.network
add address=::ffff:10.2.10.6 name=wizzy-laptop-2.foxden.network type=AAAA
add address=10.2.10.5 name=wizzy-laptop.foxden.network
add address=::ffff:10.2.10.5 name=wizzy-laptop.foxden.network type=AAAA
add address=10.2.12.10 name=amp-living-room.foxden.network
add address=::ffff:10.2.12.10 name=amp-living-room.foxden.network type=AAAA
add address=10.2.12.8 name=clock-nixie-dori.foxden.network
add address=::ffff:10.2.12.8 name=clock-nixie-dori.foxden.network type=AAAA
add address=10.2.14.2 name=dori-watch.foxden.network
add address=::ffff:10.2.14.2 name=dori-watch.foxden.network type=AAAA
add address=10.3.10.5 name=spaceage-web.foxden.network
add address=::ffff:10.3.10.5 name=spaceage-web.foxden.network type=AAAA
add address=10.3.10.4 name=spaceage-gmod.foxden.network
add address=::ffff:10.3.10.4 name=spaceage-gmod.foxden.network type=AAAA
add address=10.3.10.1 name=foxcaves.foxden.network
add address=::ffff:10.3.10.1 name=foxcaves.foxden.network type=AAAA
add address=10.2.13.4 name=sonoff-s31-lighthouse-bl.foxden.network
add address=::ffff:10.2.13.4 name=sonoff-s31-lighthouse-bl.foxden.network \
    type=AAAA
add address=10.2.13.3 name=sonoff-s31-bambu-x1.foxden.network
add address=::ffff:10.2.13.3 name=sonoff-s31-bambu-x1.foxden.network type=\
    AAAA
add address=10.2.13.8 name=sonoff-s31-dori-pc.foxden.network
add address=::ffff:10.2.13.8 name=sonoff-s31-dori-pc.foxden.network type=AAAA
add address=10.2.13.2 name=sonoff-s31-dori-office-fan.foxden.network
add address=::ffff:10.2.13.2 name=sonoff-s31-dori-office-fan.foxden.network \
    type=AAAA
add address=10.2.13.1 name=sonoff-s31-wizzy-pc.foxden.network
add address=::ffff:10.2.13.1 name=sonoff-s31-wizzy-pc.foxden.network type=\
    AAAA
add address=10.3.10.3 name=ut2004.foxden.network
add address=::ffff:10.3.10.3 name=ut2004.foxden.network type=AAAA
add address=10.2.13.10 name=custom-dori-office-desk.foxden.network
add address=::ffff:10.2.13.10 name=custom-dori-office-desk.foxden.network \
    type=AAAA
add address=10.2.13.12 name=sonoff-s31-lighthouse-br.foxden.network
add address=::ffff:10.2.13.12 name=sonoff-s31-lighthouse-br.foxden.network \
    type=AAAA
add address=10.3.10.7 name=factorio.foxden.network
add address=::ffff:10.3.10.7 name=factorio.foxden.network type=AAAA
add address=10.2.13.11 name=uplift-wizzy-desk.foxden.network
add address=::ffff:10.2.13.11 name=uplift-wizzy-desk.foxden.network type=AAAA
add address=10.6.12.1 name=islandfox-ipmi.foxden.network
add address=::ffff:10.6.12.1 name=islandfox-ipmi.foxden.network type=AAAA
add address=10.2.10.4 name=capefox-wired.foxden.network
add address=::ffff:10.2.10.4 name=capefox-wired.foxden.network type=AAAA
add address=10.2.12.11 name=homepod-dori.foxden.network
add address=::ffff:10.2.12.11 name=homepod-dori.foxden.network type=AAAA
add address=10.2.12.12 name=august-connect.foxden.network
add address=::ffff:10.2.12.12 name=august-connect.foxden.network type=AAAA
add address=10.2.12.13 name=homepod-den.foxden.network
add address=::ffff:10.2.12.13 name=homepod-den.foxden.network type=AAAA
add address=10.5.11.1 name=camera-front-door.foxden.network
add address=::ffff:10.5.11.1 name=camera-front-door.foxden.network type=AAAA
add address=10.1.10.9 name=switch-dori-office.foxden.network
add address=::ffff:10.1.10.9 name=switch-dori-office.foxden.network type=AAAA
add address=10.2.12.14 name=homepod-wizzy.foxden.network
add address=::ffff:10.2.12.14 name=homepod-wizzy.foxden.network type=AAAA
add address=10.2.12.15 name=tesla-model-3.foxden.network
add address=::ffff:10.2.12.15 name=tesla-model-3.foxden.network type=AAAA
add address=10.2.12.16 name=tesla-wall-charger.foxden.network
add address=::ffff:10.2.12.16 name=tesla-wall-charger.foxden.network type=\
    AAAA
add address=10.2.13.14 name=sonoff-s31-valve-index.foxden.network
add address=::ffff:10.2.13.14 name=sonoff-s31-valve-index.foxden.network \
    type=AAAA
add address=10.2.13.13 name=sonoff-s31-lighthouse-fl.foxden.network
add address=::ffff:10.2.13.13 name=sonoff-s31-lighthouse-fl.foxden.network \
    type=AAAA
add address=10.5.10.1 name=nvr.foxden.network
add address=::ffff:10.5.10.1 name=nvr.foxden.network type=AAAA
add address=10.4.10.1 name=bambu-x1.foxden.network
add address=::ffff:10.4.10.1 name=bambu-x1.foxden.network type=AAAA
add match-subdomain=yes name=dyn.foxden.network type=NXDOMAIN
add address=10.2.0.123 name=ntp.foxden.network
add address=::ffff:10.2.0.123 name=ntp.foxden.network type=AAAA
add address=10.2.0.53 name=dns.foxden.network
add address=::ffff:10.2.0.53 name=dns.foxden.network type=AAAA
/ip firewall filter
add action=fasttrack-connection chain=forward comment="related, established" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment="related, established" \
    connection-state=established,related
add action=accept chain=forward comment="dstnat'd" connection-nat-state=\
    dstnat
add action=accept chain=forward out-interface-list=zone-wan
add action=accept chain=forward in-interface=wg-vpn
add action=accept chain=forward in-interface=eth1-oob
add action=accept chain=forward in-interface-list=iface-mgmt
add action=accept chain=forward comment="Prometheus -> NodeExporter" \
    dst-port=9100 in-interface-list=iface-hypervisor protocol=tcp \
    src-address=10.6.11.1
add action=jump chain=forward comment="LAN whitelist" jump-target=\
    lan-out-forward out-interface-list=iface-lan
add action=jump chain=forward comment="MGMT whitelist" jump-target=\
    mgmt-out-forward out-interface-list=iface-mgmt
add action=jump chain=forward comment="LabNet whitelist" jump-target=\
    labnet-out-forward out-interface-list=iface-labnet
add action=accept chain=forward out-interface-list=iface-dmz
add action=drop chain=forward log=yes
add action=accept chain=mgmt-out-forward comment="Hypervisor -> SNMP" \
    dst-port=161 in-interface-list=iface-hypervisor protocol=udp
add action=accept chain=mgmt-out-forward comment="HomeAssistant -> SNMP" \
    dst-port=161 in-interface-list=iface-lan protocol=udp src-address=\
    10.2.12.2
add action=accept chain=mgmt-out-forward comment="NAS -> SNMP" dst-port=161 \
    in-interface-list=iface-lan protocol=udp src-address=10.2.11.1
add action=accept chain=lan-out-forward comment=HomeAssistant dst-address=\
    10.2.12.2 dst-port=80,443 protocol=tcp
add action=accept chain=lan-out-forward comment=Grafana dst-address=10.2.11.5 \
    dst-port=80,443 protocol=tcp
add action=accept chain=lan-out-forward comment=NAS dst-address=10.2.11.1 \
    dst-port=22,80,443 protocol=tcp
add action=accept chain=lan-out-forward comment=Plex dst-address=10.2.11.3 \
    dst-port=32400 protocol=tcp
add action=accept chain=labnet-out-forward comment="Bambu X1 MQTT" \
    dst-address=10.4.10.1 dst-port=1883 protocol=tcp
add action=fasttrack-connection chain=input connection-state=\
    established,related hw-offload=yes
add action=accept chain=input connection-state=established,related
add action=accept chain=input protocol=icmp
add action=accept chain=input comment="HTTP(S)" dst-port=80,443 protocol=tcp
add action=accept chain=input comment=WireGuard dst-port=13231-13232 \
    protocol=udp
add action=accept chain=input in-interface=eth1-oob
add action=accept chain=input in-interface-list=zone-local
add action=drop chain=input
/ip firewall nat
add action=masquerade chain=srcnat out-interface=sfp1-wan
add action=dst-nat chain=dstnat comment=Plex dst-port=32400 protocol=tcp \
    to-addresses=10.2.11.3
add action=dst-nat chain=dstnat comment="SpaceAge GMod" dst-port=27015 \
    protocol=udp to-addresses=10.3.10.4
add action=dst-nat chain=dstnat comment=Factorio dst-port=34197 protocol=udp \
    to-addresses=10.3.10.7
/ip route
add blackhole disabled=no dst-address=10.0.0.0/8 gateway="" routing-table=\
    main suppress-hw-offload=no
add blackhole disabled=no dst-address=192.168.0.0/16 gateway="" \
    routing-table=main suppress-hw-offload=no
add blackhole disabled=no distance=1 dst-address=172.16.0.0/12 gateway="" \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/ipv6 route
add disabled=no dst-address=::/0 gateway=2a0e:7d44:f000:a::1 routing-table=\
    main
/ip service
set telnet address=10.0.0.0/8 disabled=yes
set ftp address=10.0.0.0/8 disabled=yes
set www address=10.0.0.0/8 disabled=yes
set ssh address=10.0.0.0/8
set www-ssl address=10.0.0.0/8 certificate=\
    letsencrypt-autogen_2023-01-06T20:19:20Z disabled=no tls-version=only-1.2
set api address=10.0.0.0/8 disabled=yes
set winbox address=10.0.0.0/8
set api-ssl address=10.0.0.0/8 certificate=\
    letsencrypt-autogen_2023-01-06T20:19:20Z tls-version=only-1.2
/ip ssh
set always-allow-password-login=yes strong-crypto=yes
/ipv6 address
add address=2a0e:7d44:f000:a::2 advertise=no interface=6to4-redfox
add address=2a0e:7d44:f069:1::1 interface=sfpx2-rackswitch-agg
add address=2a0e:7d44:f069:2::1 interface=vlan-lan
add address=2a0e:7d44:f069:3::1 interface=vlan-dmz
add address=2a0e:7d44:f069:4::1 interface=vlan-labnet
add address=2a0e:7d44:f069:5::1 interface=vlan-security
add address=2a0e:7d44:f069:6::1 interface=vlan-hypervisor
/ipv6 dhcp-client
add disabled=yes interface=sfp1-wan pool-name=pool-wan request=prefix \
    use-peer-dns=no
/ipv6 firewall filter
add action=accept chain=forward connection-state=established,related
add action=accept chain=forward protocol=icmpv6
add action=accept chain=forward in-interface=wg-vpn
add action=accept chain=forward in-interface=eth1-oob
add action=accept chain=forward in-interface-list=iface-mgmt
add action=accept chain=forward out-interface-list=zone-wan
add action=accept chain=forward out-interface-list=iface-dmz
add action=drop chain=forward
add action=accept chain=input connection-state=established,related
add action=accept chain=input protocol=icmpv6
add action=accept chain=input comment="HTTP(S)" dst-port=80,443 protocol=tcp
add action=accept chain=input comment=WireGuard dst-port=13231-13232 \
    protocol=udp
add action=accept chain=input in-interface=eth1-oob
add action=accept chain=input in-interface-list=zone-local
add action=drop chain=input
/ipv6 nd
set [ find default=yes ] advertise-dns=no mtu=9000
/snmp
set contact=admin@foxden.network enabled=yes location="Server room" \
    trap-generators=""
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=router
/system ntp client
set enabled=yes
/system ntp server
set enabled=yes
/system ntp client servers
add address=10.1.0.123
/system scheduler
add interval=5m name=dyndns-update on-event=\
    "/system script run dyndns-update" policy=read,test start-date=\
    aug/09/2020 start-time=09:41:00
add interval=5m name=ipv6tun-update on-event=\
    "/system script run ipv6tun-update" policy=read,test start-date=\
    aug/09/2020 start-time=09:43:00
add disabled=yes interval=30s name=pingcheck on-event=\
    "/system script run pingcheck" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=dec/03/2020 start-time=00:00:00
add interval=5m name=redfoxv6-up on-event="/system script run redfoxv6-up" \
    policy=read,test start-date=aug/09/2020 start-time=09:45:00
/system script
add dont-require-permissions=no name=static-dns-for-dhcp owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_DNS record for DHCP lease\r\
    \n# Prepare variables in use\r\
    \n:local topdomain;\r\
    \n:local hostname;\r\
    \n:local hostip;\r\
    \n\r\
    \n# Configure your domain\r\
    \n:set topdomain \"foxden.network\";\r\
    \n\r\
    \n/ip dhcp-server lease;\r\
    \n:foreach i in=[find] do={\r\
    \n  /ip dhcp-server lease;\r\
    \n  :if ([:len [get \$i comment]] > 0) do={\r\
    \n    :set hostname ([get \$i comment] . \".\" . \$topdomain);\r\
    \n    :set hostip [get \$i address];\r\
    \n    /ip dns static;\r\
    \n# Remove if DNS entry already exist\r\
    \n    :foreach di in [find] do={\r\
    \n      :if ([get \$di name] = \$hostname) do={\r\
    \n        :put (\"Removing: \" . \$hostname . \" : \" . \$hostip);\r\
    \n        remove \$di;\r\
    \n      }\r\
    \n    }\r\
    \n# Add DNS entry\r\
    \n    :put (\"Adding: \" . \$hostname . \" : \" . \$hostip);\r\
    \n    /ip dns static add type=A name=\$hostname address=\$hostip;\r\
    \n    /ip dns static add type=AAAA name=\$hostname address=\"::ffff:\$host\
    ip\";\r\
    \n  }\r\
    \n}"
add dont-require-permissions=yes name=dyndns-update owner=admin policy=\
    read,test source=":local ddnshost \"router.dyn.foxden.network\"\r\
    \n:local key \"REMOVED\"\r\
    \n:local updatehost \"dyn.dns.he.net\"\r\
    \n\r\
    \n:local result [/tool fetch mode=https url=\"https://\$updatehost/nic/upd\
    ate\?hostname=\$ddnshost\" user=\"\$ddnshost\" password=\"\$key\" as-value\
    \_output=user]\r\
    \n:log debug (\$result->\"data\")\r\
    \n\r\
    \n"
add dont-require-permissions=yes name=ipv6tun-update owner=admin policy=\
    read,test source=":local ddnshost \"772305\"\r\
    \n:local user \"doridian\"\r\
    \n:local key \"REMOVED\"\r\
    \n:local updatehost \"ipv4.tunnelbroker.net\"\r\
    \n\r\
    \n:local result [/tool fetch mode=https url=\"https://\$updatehost/nic/upd\
    ate\?hostname=\$ddnshost\" user=\"\$user\" password=\"\$key\" as-value out\
    put=user]\r\
    \n:log debug (\$result->\"data\")\r\
    \n"
add dont-require-permissions=yes name=redfoxv6-update owner=admin policy=\
    read,test source=":local ipaddr [/ip/address/get [ /ip/address/find  inter\
    face=sfp1-wan ] address]\r\
    \n\r\
    \n:local result [/tool fetch mode=https url=\"http://10.99.10.1:9999/updat\
    e-ip\?ip=\$ipaddr\" as-value output=user]\r\
    \n:log debug (\$result->\"data\")\r\
    \n"
