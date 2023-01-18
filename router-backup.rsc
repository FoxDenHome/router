# jan/17/2023 20:21:37 by RouterOS 7.7
# software id = REMOVED
#
# model = RB5009UG+S+
# serial number = REMOVED
/interface ethernet
set [ find default-name=ether2 ] disabled=yes name=eth2
set [ find default-name=ether3 ] disabled=yes name=eth3
set [ find default-name=ether4 ] disabled=yes name=eth4
set [ find default-name=ether5 ] disabled=yes name=eth5
set [ find default-name=ether6 ] disabled=yes name=eth6
set [ find default-name=ether7 ] disabled=yes name=eth7
set [ find default-name=ether8 ] comment=eth8 name=oob
set [ find default-name=sfp-sfpplus1 ] advertise=1000M-full,10000M-full \
    comment=sfp1 l2mtu=9092 mtu=9000 name=vlan-mgmt
set [ find default-name=ether1 ] advertise=1000M-full,2500M-full comment=eth1 \
    name=wan rx-flow-control=on tx-flow-control=on
/interface 6to4
add !keepalive name=6to4-redfox remote-address=66.42.71.230
/interface vrrp
add interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-dns priority=5 vrid=53
add interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-gateway priority=5
add interface=vlan-mgmt mtu=9000 name=vrrp-mgmt-ntp priority=5 version=2 \
    vrid=123
/interface wireguard
add listen-port=13232 mtu=1420 name=wg-s2s
add listen-port=13231 mtu=1420 name=wg-vpn
/interface vlan
add interface=vlan-mgmt mtu=9000 name=vlan-dmz vlan-id=3
add interface=vlan-mgmt mtu=9000 name=vlan-hypervisor vlan-id=6
add interface=vlan-mgmt mtu=9000 name=vlan-labnet vlan-id=4
add interface=vlan-mgmt mtu=9000 name=vlan-lan vlan-id=2
add interface=vlan-mgmt mtu=9000 name=vlan-security vlan-id=5
/interface vrrp
add interface=vlan-dmz mtu=9000 name=vrrp-dmz-dns priority=5 vrid=53
add interface=vlan-dmz mtu=9000 name=vrrp-dmz-gateway priority=5
add interface=vlan-dmz mtu=9000 name=vrrp-dmz-ntp priority=5 version=2 vrid=\
    123
add interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-dns priority=5 \
    vrid=53
add interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-gateway priority=\
    5
add interface=vlan-hypervisor mtu=9000 name=vrrp-hypervisor-ntp priority=5 \
    version=2 vrid=123
add interface=vlan-labnet mtu=9000 name=vrrp-labnet-dns priority=5 vrid=53
add interface=vlan-labnet mtu=9000 name=vrrp-labnet-gateway priority=5
add interface=vlan-labnet mtu=9000 name=vrrp-labnet-ntp priority=5 version=2 \
    vrid=123
add interface=vlan-lan mtu=9000 name=vrrp-lan-dns priority=5 vrid=53
add interface=vlan-lan mtu=9000 name=vrrp-lan-gateway priority=5
add interface=vlan-lan mtu=9000 name=vrrp-lan-ntp priority=5 version=2 vrid=\
    123
add interface=vlan-security mtu=9000 name=vrrp-security-dns priority=5 vrid=\
    53
add interface=vlan-security mtu=9000 name=vrrp-security-gateway priority=5
add interface=vlan-security mtu=9000 name=vrrp-security-ntp priority=5 \
    version=2 vrid=123
/disk
add slot=docker tmpfs-max-size=128000000 type=tmpfs
add slot=tmpfs-scratch tmpfs-max-size=16000000 type=tmpfs
set usb1-part1 parent=usb1 partition-offset=512 partition-size=\
    "32 017 047 040"
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
    vrrp-labnet-gateway lease-time=1h name=dhcp-labnet
add address-pool=pool-lan dhcp-option-set=default-classless interface=\
    vrrp-lan-gateway lease-time=1h name=dhcp-lan
add address-pool=pool-dmz dhcp-option-set=default-classless interface=\
    vrrp-dmz-gateway lease-time=1h name=dhcp-dmz
add address-pool=pool-mgmt dhcp-option-set=default-classless interface=\
    vrrp-mgmt-gateway lease-time=1h name=dhcp-mgmt
add address-pool=pool-security dhcp-option-set=default-classless interface=\
    vrrp-security-gateway lease-time=1h name=dhcp-security
add address-pool=pool-hypervisor dhcp-option-set=default-classless interface=\
    vrrp-hypervisor-gateway lease-time=1h name=dhcp-hypervisor
add address-pool=pool-oob bootp-support=none interface=oob lease-time=1h \
    name=dhcp-oob
/port
set 0 baud-rate=115200 data-bits=8 flow-control=none name=usb1 parity=none \
    stop-bits=1
/snmp community
set [ find default=yes ] disabled=yes
add addresses=::/0 name=monitor_REMOVED
/dude
set data-directory=usb1-part1/dude enabled=yes
/ip settings
set rp-filter=loose tcp-syncookies=yes
/ipv6 settings
set accept-redirects=no accept-router-advertisements=no
/interface list member
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
add interface=wan list=zone-wan
add interface=vlan-mgmt list=iface-mgmt
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
add address=10.1.1.3/16 interface=vlan-mgmt network=10.1.0.0
add address=192.168.88.100/24 interface=oob network=192.168.88.0
add address=10.2.1.3/16 interface=vlan-lan network=10.2.0.0
add address=10.3.1.3/16 interface=vlan-dmz network=10.3.0.0
add address=10.4.1.3/16 interface=vlan-labnet network=10.4.0.0
add address=10.5.1.3/16 interface=vlan-security network=10.5.0.0
add address=10.6.1.3/16 interface=vlan-hypervisor network=10.6.0.0
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
add address=10.99.0.3/16 interface=wg-s2s network=10.99.0.0
add address=10.100.0.1/16 interface=wg-vpn network=10.100.0.0
/ip cloud
set update-time=no
/ip dhcp-client
add default-route-distance=5 interface=wan script=\
    "/system/script/run vrrp-priority-adjust\r\
    \n" use-peer-dns=no use-peer-ntp=no
/ip dhcp-server config
set store-leases-disk=never
/ip dhcp-server lease
add address=10.2.10.3 comment=capefox lease-time=1d mac-address=\
    F0:2F:4B:14:84:F4 server=dhcp-lan
add address=10.6.10.2 comment=islandfox lease-time=1d mac-address=\
    0A:98:86:2C:85:87 server=dhcp-hypervisor
add address=10.2.10.1 comment=fennec lease-time=1d mac-address=\
    00:02:C9:23:3C:E0 server=dhcp-lan
add address=10.2.11.1 comment=nas lease-time=1d mac-address=50:6B:4B:4B:90:5E \
    server=dhcp-lan
add address=10.2.10.2 comment=wizzy-desktop lease-time=1d mac-address=\
    EC:0D:9A:21:DF:70 server=dhcp-lan
add address=10.1.12.1 comment=nas-ipmi lease-time=1d mac-address=\
    00:25:90:6D:05:12 server=dhcp-mgmt
add address=10.1.10.4 comment=switch-living-room lease-time=1d mac-address=\
    80:2A:A8:DE:F0:AE server=dhcp-mgmt
add address=10.1.11.1 comment=pdu-rack lease-time=1d mac-address=\
    70:A7:41:F8:13:09 server=dhcp-mgmt
add address=10.1.10.2 comment=switch-rack lease-time=1d mac-address=\
    24:5A:4C:A6:6B:9A server=dhcp-mgmt
add address=10.1.10.3 comment=switch-rack-agg lease-time=1d mac-address=\
    24:5A:4C:56:41:C4 server=dhcp-mgmt
add address=10.1.11.2 comment=ups-rack lease-time=1d mac-address=\
    00:C0:B7:E8:B2:A0 server=dhcp-mgmt
add address=10.1.10.1 comment=unifi lease-time=1d mac-address=\
    24:5A:4C:8A:23:3F server=dhcp-mgmt
add address=10.1.10.6 comment=ap-server-room lease-time=1d mac-address=\
    68:D7:9A:1F:57:E2 server=dhcp-mgmt
add address=10.1.10.7 comment=ap-corridor-upper lease-time=1d mac-address=\
    60:22:32:1D:48:15 server=dhcp-mgmt
add address=10.1.10.5 comment=switch-workbench lease-time=1d mac-address=\
    74:83:C2:FF:87:16 server=dhcp-mgmt
add address=10.1.10.10 comment=switch-dori-office lease-time=1d mac-address=\
    60:22:32:39:77:9C server=dhcp-mgmt
add address=10.1.10.8 comment=switch-dori-office-10g lease-time=1d \
    mac-address=18:FD:74:7B:0C:B9 server=dhcp-mgmt
add address=10.6.11.2 comment=telegraf lease-time=1d mac-address=\
    42:FE:0C:C8:E0:F5 server=dhcp-hypervisor
add address=10.2.11.2 comment=syncthing lease-time=1d mac-address=\
    AE:FC:DD:8B:33:76 server=dhcp-lan
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
    00:16:3E:CA:7E:03 server=dhcp-lan
add address=10.6.11.1 comment=prometheus lease-time=1d mac-address=\
    4A:97:18:7B:69:10 server=dhcp-hypervisor
add address=10.2.11.5 comment=grafana lease-time=1d mac-address=\
    7E:18:E9:41:A9:6C server=dhcp-lan
add address=10.2.11.6 comment=kiwix lease-time=1d mac-address=\
    00:16:3E:CA:7E:01 server=dhcp-lan
add address=10.2.11.8 comment=dldr lease-time=1d mac-address=\
    CA:1B:F1:2C:6C:B3 server=dhcp-lan
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
    E2:47:0B:F9:D1:F1 server=dhcp-lan
add address=10.3.10.5 comment=spaceage-web lease-time=1d mac-address=\
    62:BF:FB:E4:89:5D server=dhcp-dmz
add address=10.3.10.4 comment=spaceage-gmod lease-time=1d mac-address=\
    5E:47:05:FC:F8:90 server=dhcp-dmz
add address=10.3.10.1 comment=foxcaves lease-time=1d mac-address=\
    A6:92:B3:48:21:9D server=dhcp-dmz
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
    02:43:39:4D:B6:AA server=dhcp-dmz
add address=10.2.13.12 comment=sonoff-s31-lighthouse-br lease-time=1d \
    mac-address=C4:5B:BE:E4:9B:00 server=dhcp-lan
add address=10.3.10.7 comment=factorio lease-time=1d mac-address=\
    36:16:0C:C9:E8:0B server=dhcp-dmz
add address=10.2.13.11 comment=uplift-wizzy-desk lease-time=1d mac-address=\
    40:91:51:52:11:F7 server=dhcp-lan
add address=10.6.12.1 comment=islandfox-ipmi lease-time=1d mac-address=\
    04:7B:CB:44:C0:DD server=dhcp-hypervisor
add address=10.2.10.4 client-id=capefox comment=capefox-wired lease-time=1d \
    mac-address=00:30:93:12:12:38 server=dhcp-lan
add address=10.2.12.11 comment=homepod-dori lease-time=1d mac-address=\
    04:99:B9:66:DE:D0 server=dhcp-lan
add address=10.2.12.12 comment=august-connect-front-door lease-time=1d \
    mac-address=D8:61:62:12:6A:08 server=dhcp-lan
add address=10.2.12.13 comment=homepod-den lease-time=1d mac-address=\
    04:99:B9:9E:9B:95 server=dhcp-lan
add address=10.5.11.1 comment=camera-front-door lease-time=1d mac-address=\
    D0:21:F9:94:97:13 server=dhcp-security
add address=10.1.10.9 comment=switch-dori-tv lease-time=1d mac-address=\
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
add address=10.2.12.18 comment=hue-sync-box lease-time=1d mac-address=\
    C4:29:96:0B:9C:82 server=dhcp-lan
add address=10.2.13.19 comment=sonoff-s31-microwave lease-time=1d \
    mac-address=C4:5B:BE:E4:B7:03 server=dhcp-lan
add address=10.2.13.20 comment=custom-garage-door lease-time=1d mac-address=\
    4C:EB:D6:0B:80:73 server=dhcp-lan
add address=10.2.13.16 comment=airgradient-den lease-time=1d mac-address=\
    0C:B8:15:C4:B3:74 server=dhcp-lan
add address=10.2.13.15 comment=custom-current-clamp-main lease-time=1d \
    mac-address=40:91:51:51:D0:A6 server=dhcp-lan
add address=10.5.11.4 lease-time=1d mac-address=D0:21:F9:99:60:DA server=\
    dhcp-security
add address=10.5.11.3 lease-time=1d mac-address=70:A7:41:5F:DB:54 server=\
    dhcp-security
add address=10.5.11.5 lease-time=1d mac-address=70:A7:41:0B:11:36 server=\
    dhcp-security
add address=10.2.13.17 comment=airgradient-wizzy-office lease-time=1d \
    mac-address=0C:B8:15:C4:B8:D0 server=dhcp-lan
add address=10.2.10.7 comment=mbp-mark-dietzer lease-time=1d mac-address=\
    BC:D0:74:45:61:FB server=dhcp-lan
add address=10.2.12.17 comment=august-connect-back-door-upper lease-time=1d \
    mac-address=2C:9F:FB:16:5F:B7 server=dhcp-lan
add address=10.2.13.18 comment=uplift-dori-desk lease-time=1d mac-address=\
    40:91:51:51:E8:B6 server=dhcp-lan
add address=10.2.12.50 comment=amp-living-room-wifi lease-time=1d \
    mac-address=EC:F4:51:D0:8C:B0 server=dhcp-lan
add address=10.2.12.19 comment=nanoleaf-lines-wizzy lease-time=1d \
    mac-address=80:8A:F7:03:55:58 server=dhcp-lan
add address=10.2.12.20 comment=nanoleaf-shapes-dori lease-time=1d \
    mac-address=80:8A:F7:03:EA:58 server=dhcp-lan
add address=10.2.14.5 comment=dori-ipad lease-time=1d mac-address=\
    6E:42:DD:F2:32:D8 server=dhcp-lan
add address=10.1.10.11 comment=ap-living-room lease-time=1d mac-address=\
    60:22:32:83:6D:9E server=dhcp-mgmt
add address=10.2.14.6 comment=dori-remarkable lease-time=1d mac-address=\
    C0:84:7D:20:57:C0 server=dhcp-lan
add address=10.2.10.8 comment=thunderbolt-10g lease-time=1d mac-address=\
    00:30:93:12:12:38 server=dhcp-lan
add address=10.2.13.9 comment=custom-filament-dryer lease-time=1d \
    mac-address=0C:B8:15:D5:C0:88 server=dhcp-lan
add address=10.2.12.21 comment=laundry-washer lease-time=1d mac-address=\
    88:57:1D:85:70:9A server=dhcp-lan
add address=10.2.12.22 comment=laundry-dryer lease-time=1d mac-address=\
    88:57:1D:85:70:A1 server=dhcp-lan
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
add address=192.168.88.0/24 dns-none=yes
/ip dns
set allow-remote-requests=yes cache-size=20480KiB servers=8.8.8.8,8.8.4.4 \
    use-doh-server=https://dns.google/dns-query verify-doh-cert=yes
/ip dns static
add address=10.2.1.1 name=router.foxden.network
add address=10.2.1.3 name=router-backup.foxden.network
add address=::ffff:10.2.1.1 name=router.foxden.network type=AAAA
add address=::ffff:10.2.1.3 name=router-backup.foxden.network type=AAAA
add address=10.2.1.1 name=vpn.foxden.network
add address=::ffff:10.2.1.1 name=vpn.foxden.network type=AAAA
add match-subdomain=yes name=dyn.foxden.network type=NXDOMAIN
add address=10.2.0.123 name=ntp.foxden.network
add address=::ffff:10.2.0.123 name=ntp.foxden.network type=AAAA
add address=10.2.0.53 name=dns.foxden.network
add address=::ffff:10.2.0.53 name=dns.foxden.network type=AAAA
add address=10.2.10.3 comment=static-dns-for-dhcp name=capefox.foxden.network
add address=::ffff:10.2.10.3 comment=static-dns-for-dhcp name=\
    capefox.foxden.network type=AAAA
add address=10.6.10.2 comment=static-dns-for-dhcp name=\
    islandfox.foxden.network
add address=::ffff:10.6.10.2 comment=static-dns-for-dhcp name=\
    islandfox.foxden.network type=AAAA
add address=10.2.10.1 comment=static-dns-for-dhcp name=fennec.foxden.network
add address=::ffff:10.2.10.1 comment=static-dns-for-dhcp name=\
    fennec.foxden.network type=AAAA
add address=10.2.11.1 comment=static-dns-for-dhcp name=nas.foxden.network
add address=::ffff:10.2.11.1 comment=static-dns-for-dhcp name=\
    nas.foxden.network type=AAAA
add address=10.2.10.2 comment=static-dns-for-dhcp name=\
    wizzy-desktop.foxden.network
add address=::ffff:10.2.10.2 comment=static-dns-for-dhcp name=\
    wizzy-desktop.foxden.network type=AAAA
add address=10.1.12.1 comment=static-dns-for-dhcp name=\
    nas-ipmi.foxden.network
add address=::ffff:10.1.12.1 comment=static-dns-for-dhcp name=\
    nas-ipmi.foxden.network type=AAAA
add address=10.1.10.4 comment=static-dns-for-dhcp name=\
    switch-living-room.foxden.network
add address=::ffff:10.1.10.4 comment=static-dns-for-dhcp name=\
    switch-living-room.foxden.network type=AAAA
add address=10.1.11.1 comment=static-dns-for-dhcp name=\
    pdu-rack.foxden.network
add address=::ffff:10.1.11.1 comment=static-dns-for-dhcp name=\
    pdu-rack.foxden.network type=AAAA
add address=10.1.10.2 comment=static-dns-for-dhcp name=\
    switch-rack.foxden.network
add address=::ffff:10.1.10.2 comment=static-dns-for-dhcp name=\
    switch-rack.foxden.network type=AAAA
add address=10.1.10.3 comment=static-dns-for-dhcp name=\
    switch-rack-agg.foxden.network
add address=::ffff:10.1.10.3 comment=static-dns-for-dhcp name=\
    switch-rack-agg.foxden.network type=AAAA
add address=10.1.11.2 comment=static-dns-for-dhcp name=\
    ups-rack.foxden.network
add address=::ffff:10.1.11.2 comment=static-dns-for-dhcp name=\
    ups-rack.foxden.network type=AAAA
add address=10.1.10.1 comment=static-dns-for-dhcp name=unifi.foxden.network
add address=::ffff:10.1.10.1 comment=static-dns-for-dhcp name=\
    unifi.foxden.network type=AAAA
add address=10.1.10.6 comment=static-dns-for-dhcp name=\
    ap-server-room.foxden.network
add address=::ffff:10.1.10.6 comment=static-dns-for-dhcp name=\
    ap-server-room.foxden.network type=AAAA
add address=10.1.10.7 comment=static-dns-for-dhcp name=\
    ap-corridor-upper.foxden.network
add address=::ffff:10.1.10.7 comment=static-dns-for-dhcp name=\
    ap-corridor-upper.foxden.network type=AAAA
add address=10.1.10.5 comment=static-dns-for-dhcp name=\
    switch-workbench.foxden.network
add address=::ffff:10.1.10.5 comment=static-dns-for-dhcp name=\
    switch-workbench.foxden.network type=AAAA
add address=10.1.10.10 comment=static-dns-for-dhcp name=\
    switch-dori-office.foxden.network
add address=::ffff:10.1.10.10 comment=static-dns-for-dhcp name=\
    switch-dori-office.foxden.network type=AAAA
add address=10.1.10.8 comment=static-dns-for-dhcp name=\
    switch-dori-office-10g.foxden.network
add address=::ffff:10.1.10.8 comment=static-dns-for-dhcp name=\
    switch-dori-office-10g.foxden.network type=AAAA
add address=10.6.11.2 comment=static-dns-for-dhcp name=\
    telegraf.foxden.network
add address=::ffff:10.6.11.2 comment=static-dns-for-dhcp name=\
    telegraf.foxden.network type=AAAA
add address=10.2.11.2 comment=static-dns-for-dhcp name=\
    syncthing.foxden.network
add address=::ffff:10.2.11.2 comment=static-dns-for-dhcp name=\
    syncthing.foxden.network type=AAAA
add address=10.1.11.3 comment=static-dns-for-dhcp name=\
    ups-dori-office.foxden.network
add address=::ffff:10.1.11.3 comment=static-dns-for-dhcp name=\
    ups-dori-office.foxden.network type=AAAA
add address=10.2.12.3 comment=static-dns-for-dhcp name=printer.foxden.network
add address=::ffff:10.2.12.3 comment=static-dns-for-dhcp name=\
    printer.foxden.network type=AAAA
add address=10.2.12.1 comment=static-dns-for-dhcp name=hue.foxden.network
add address=::ffff:10.2.12.1 comment=static-dns-for-dhcp name=\
    hue.foxden.network type=AAAA
add address=10.2.12.2 comment=static-dns-for-dhcp name=\
    homeassistant.foxden.network
add address=::ffff:10.2.12.2 comment=static-dns-for-dhcp name=\
    homeassistant.foxden.network type=AAAA
add address=10.5.11.2 comment=static-dns-for-dhcp name=\
    camera-living-room.foxden.network
add address=::ffff:10.5.11.2 comment=static-dns-for-dhcp name=\
    camera-living-room.foxden.network type=AAAA
add address=10.2.11.3 comment=static-dns-for-dhcp name=plex.foxden.network
add address=::ffff:10.2.11.3 comment=static-dns-for-dhcp name=\
    plex.foxden.network type=AAAA
add address=10.6.11.1 comment=static-dns-for-dhcp name=\
    prometheus.foxden.network
add address=::ffff:10.6.11.1 comment=static-dns-for-dhcp name=\
    prometheus.foxden.network type=AAAA
add address=10.2.11.5 comment=static-dns-for-dhcp name=grafana.foxden.network
add address=::ffff:10.2.11.5 comment=static-dns-for-dhcp name=\
    grafana.foxden.network type=AAAA
add address=10.2.11.6 comment=static-dns-for-dhcp name=kiwix.foxden.network
add address=::ffff:10.2.11.6 comment=static-dns-for-dhcp name=\
    kiwix.foxden.network type=AAAA
add address=10.2.11.8 comment=static-dns-for-dhcp name=dldr.foxden.network
add address=::ffff:10.2.11.8 comment=static-dns-for-dhcp name=\
    dldr.foxden.network type=AAAA
add address=10.2.12.7 comment=static-dns-for-dhcp name=\
    clock-nixie-zen.foxden.network
add address=::ffff:10.2.12.7 comment=static-dns-for-dhcp name=\
    clock-nixie-zen.foxden.network type=AAAA
add address=10.2.13.7 comment=static-dns-for-dhcp name=\
    airgradient-bedroom.foxden.network
add address=::ffff:10.2.13.7 comment=static-dns-for-dhcp name=\
    airgradient-bedroom.foxden.network type=AAAA
add address=10.2.13.6 comment=static-dns-for-dhcp name=\
    airgradient-living-room.foxden.network
add address=::ffff:10.2.13.6 comment=static-dns-for-dhcp name=\
    airgradient-living-room.foxden.network type=AAAA
add address=10.2.13.5 comment=static-dns-for-dhcp name=\
    airgradient-dori-office.foxden.network
add address=::ffff:10.2.13.5 comment=static-dns-for-dhcp name=\
    airgradient-dori-office.foxden.network type=AAAA
add address=10.2.12.9 comment=static-dns-for-dhcp name=\
    vacuum-neato.foxden.network
add address=::ffff:10.2.12.9 comment=static-dns-for-dhcp name=\
    vacuum-neato.foxden.network type=AAAA
add address=10.2.12.4 comment=static-dns-for-dhcp name=\
    homepod-living-room.foxden.network
add address=::ffff:10.2.12.4 comment=static-dns-for-dhcp name=\
    homepod-living-room.foxden.network type=AAAA
add address=10.2.12.5 comment=static-dns-for-dhcp name=\
    homepod-bedroom.foxden.network
add address=::ffff:10.2.12.5 comment=static-dns-for-dhcp name=\
    homepod-bedroom.foxden.network type=AAAA
add address=10.2.14.1 comment=static-dns-for-dhcp name=\
    dori-phone.foxden.network
add address=::ffff:10.2.14.1 comment=static-dns-for-dhcp name=\
    dori-phone.foxden.network type=AAAA
add address=10.2.12.6 comment=static-dns-for-dhcp name=\
    appletv-living-room.foxden.network
add address=::ffff:10.2.12.6 comment=static-dns-for-dhcp name=\
    appletv-living-room.foxden.network type=AAAA
add address=10.2.15.1 comment=static-dns-for-dhcp name=\
    nintendo-switch-wired.foxden.network
add address=::ffff:10.2.15.1 comment=static-dns-for-dhcp name=\
    nintendo-switch-wired.foxden.network type=AAAA
add address=10.2.14.3 comment=static-dns-for-dhcp name=\
    wizzy-phone.foxden.network
add address=::ffff:10.2.14.3 comment=static-dns-for-dhcp name=\
    wizzy-phone.foxden.network type=AAAA
add address=10.2.14.4 comment=static-dns-for-dhcp name=\
    wizzy-watch.foxden.network
add address=::ffff:10.2.14.4 comment=static-dns-for-dhcp name=\
    wizzy-watch.foxden.network type=AAAA
add address=10.2.10.6 comment=static-dns-for-dhcp name=\
    wizzy-laptop-2.foxden.network
add address=::ffff:10.2.10.6 comment=static-dns-for-dhcp name=\
    wizzy-laptop-2.foxden.network type=AAAA
add address=10.2.10.5 comment=static-dns-for-dhcp name=\
    wizzy-laptop.foxden.network
add address=::ffff:10.2.10.5 comment=static-dns-for-dhcp name=\
    wizzy-laptop.foxden.network type=AAAA
add address=10.2.12.10 comment=static-dns-for-dhcp name=\
    amp-living-room.foxden.network
add address=::ffff:10.2.12.10 comment=static-dns-for-dhcp name=\
    amp-living-room.foxden.network type=AAAA
add address=10.2.12.8 comment=static-dns-for-dhcp name=\
    clock-nixie-dori.foxden.network
add address=::ffff:10.2.12.8 comment=static-dns-for-dhcp name=\
    clock-nixie-dori.foxden.network type=AAAA
add address=10.2.14.2 comment=static-dns-for-dhcp name=\
    dori-watch.foxden.network
add address=::ffff:10.2.14.2 comment=static-dns-for-dhcp name=\
    dori-watch.foxden.network type=AAAA
add address=10.3.10.5 comment=static-dns-for-dhcp name=\
    spaceage-web.foxden.network
add address=::ffff:10.3.10.5 comment=static-dns-for-dhcp name=\
    spaceage-web.foxden.network type=AAAA
add address=10.3.10.4 comment=static-dns-for-dhcp name=\
    spaceage-gmod.foxden.network
add address=::ffff:10.3.10.4 comment=static-dns-for-dhcp name=\
    spaceage-gmod.foxden.network type=AAAA
add address=10.3.10.1 comment=static-dns-for-dhcp name=\
    foxcaves.foxden.network
add address=::ffff:10.3.10.1 comment=static-dns-for-dhcp name=\
    foxcaves.foxden.network type=AAAA
add address=10.2.13.4 comment=static-dns-for-dhcp name=\
    sonoff-s31-lighthouse-bl.foxden.network
add address=::ffff:10.2.13.4 comment=static-dns-for-dhcp name=\
    sonoff-s31-lighthouse-bl.foxden.network type=AAAA
add address=10.2.13.3 comment=static-dns-for-dhcp name=\
    sonoff-s31-bambu-x1.foxden.network
add address=::ffff:10.2.13.3 comment=static-dns-for-dhcp name=\
    sonoff-s31-bambu-x1.foxden.network type=AAAA
add address=10.2.13.8 comment=static-dns-for-dhcp name=\
    sonoff-s31-dori-pc.foxden.network
add address=::ffff:10.2.13.8 comment=static-dns-for-dhcp name=\
    sonoff-s31-dori-pc.foxden.network type=AAAA
add address=10.2.13.2 comment=static-dns-for-dhcp name=\
    sonoff-s31-dori-office-fan.foxden.network
add address=::ffff:10.2.13.2 comment=static-dns-for-dhcp name=\
    sonoff-s31-dori-office-fan.foxden.network type=AAAA
add address=10.2.13.1 comment=static-dns-for-dhcp name=\
    sonoff-s31-wizzy-pc.foxden.network
add address=::ffff:10.2.13.1 comment=static-dns-for-dhcp name=\
    sonoff-s31-wizzy-pc.foxden.network type=AAAA
add address=10.3.10.3 comment=static-dns-for-dhcp name=ut2004.foxden.network
add address=::ffff:10.3.10.3 comment=static-dns-for-dhcp name=\
    ut2004.foxden.network type=AAAA
add address=10.2.13.12 comment=static-dns-for-dhcp name=\
    sonoff-s31-lighthouse-br.foxden.network
add address=::ffff:10.2.13.12 comment=static-dns-for-dhcp name=\
    sonoff-s31-lighthouse-br.foxden.network type=AAAA
add address=10.3.10.7 comment=static-dns-for-dhcp name=\
    factorio.foxden.network
add address=::ffff:10.3.10.7 comment=static-dns-for-dhcp name=\
    factorio.foxden.network type=AAAA
add address=10.2.13.11 comment=static-dns-for-dhcp name=\
    uplift-wizzy-desk.foxden.network
add address=::ffff:10.2.13.11 comment=static-dns-for-dhcp name=\
    uplift-wizzy-desk.foxden.network type=AAAA
add address=10.6.12.1 comment=static-dns-for-dhcp name=\
    islandfox-ipmi.foxden.network
add address=::ffff:10.6.12.1 comment=static-dns-for-dhcp name=\
    islandfox-ipmi.foxden.network type=AAAA
add address=10.2.10.4 comment=static-dns-for-dhcp name=\
    capefox-wired.foxden.network
add address=::ffff:10.2.10.4 comment=static-dns-for-dhcp name=\
    capefox-wired.foxden.network type=AAAA
add address=10.2.12.11 comment=static-dns-for-dhcp name=\
    homepod-dori.foxden.network
add address=::ffff:10.2.12.11 comment=static-dns-for-dhcp name=\
    homepod-dori.foxden.network type=AAAA
add address=10.2.12.12 comment=static-dns-for-dhcp name=\
    august-connect-front-door.foxden.network
add address=::ffff:10.2.12.12 comment=static-dns-for-dhcp name=\
    august-connect-front-door.foxden.network type=AAAA
add address=10.2.12.13 comment=static-dns-for-dhcp name=\
    homepod-den.foxden.network
add address=::ffff:10.2.12.13 comment=static-dns-for-dhcp name=\
    homepod-den.foxden.network type=AAAA
add address=10.5.11.1 comment=static-dns-for-dhcp name=\
    camera-front-door.foxden.network
add address=::ffff:10.5.11.1 comment=static-dns-for-dhcp name=\
    camera-front-door.foxden.network type=AAAA
add address=10.1.10.9 comment=static-dns-for-dhcp name=\
    switch-dori-tv.foxden.network
add address=::ffff:10.1.10.9 comment=static-dns-for-dhcp name=\
    switch-dori-tv.foxden.network type=AAAA
add address=10.2.12.14 comment=static-dns-for-dhcp name=\
    homepod-wizzy.foxden.network
add address=::ffff:10.2.12.14 comment=static-dns-for-dhcp name=\
    homepod-wizzy.foxden.network type=AAAA
add address=10.2.12.15 comment=static-dns-for-dhcp name=\
    tesla-model-3.foxden.network
add address=::ffff:10.2.12.15 comment=static-dns-for-dhcp name=\
    tesla-model-3.foxden.network type=AAAA
add address=10.2.12.16 comment=static-dns-for-dhcp name=\
    tesla-wall-charger.foxden.network
add address=::ffff:10.2.12.16 comment=static-dns-for-dhcp name=\
    tesla-wall-charger.foxden.network type=AAAA
add address=10.2.13.14 comment=static-dns-for-dhcp name=\
    sonoff-s31-valve-index.foxden.network
add address=::ffff:10.2.13.14 comment=static-dns-for-dhcp name=\
    sonoff-s31-valve-index.foxden.network type=AAAA
add address=10.2.13.13 comment=static-dns-for-dhcp name=\
    sonoff-s31-lighthouse-fl.foxden.network
add address=::ffff:10.2.13.13 comment=static-dns-for-dhcp name=\
    sonoff-s31-lighthouse-fl.foxden.network type=AAAA
add address=10.5.10.1 comment=static-dns-for-dhcp name=nvr.foxden.network
add address=::ffff:10.5.10.1 comment=static-dns-for-dhcp name=\
    nvr.foxden.network type=AAAA
add address=10.4.10.1 comment=static-dns-for-dhcp name=\
    bambu-x1.foxden.network
add address=::ffff:10.4.10.1 comment=static-dns-for-dhcp name=\
    bambu-x1.foxden.network type=AAAA
add address=10.2.12.18 comment=static-dns-for-dhcp name=\
    hue-sync-box.foxden.network
add address=::ffff:10.2.12.18 comment=static-dns-for-dhcp name=\
    hue-sync-box.foxden.network type=AAAA
add address=10.2.13.19 comment=static-dns-for-dhcp name=\
    sonoff-s31-microwave.foxden.network
add address=::ffff:10.2.13.19 comment=static-dns-for-dhcp name=\
    sonoff-s31-microwave.foxden.network type=AAAA
add address=10.2.13.20 comment=static-dns-for-dhcp name=\
    custom-garage-door.foxden.network
add address=::ffff:10.2.13.20 comment=static-dns-for-dhcp name=\
    custom-garage-door.foxden.network type=AAAA
add address=10.2.13.16 comment=static-dns-for-dhcp name=\
    airgradient-den.foxden.network
add address=::ffff:10.2.13.16 comment=static-dns-for-dhcp name=\
    airgradient-den.foxden.network type=AAAA
add address=10.2.13.15 comment=static-dns-for-dhcp name=\
    custom-current-clamp-main.foxden.network
add address=::ffff:10.2.13.15 comment=static-dns-for-dhcp name=\
    custom-current-clamp-main.foxden.network type=AAAA
add address=10.2.13.17 comment=static-dns-for-dhcp name=\
    airgradient-wizzy-office.foxden.network
add address=::ffff:10.2.13.17 comment=static-dns-for-dhcp name=\
    airgradient-wizzy-office.foxden.network type=AAAA
add address=10.2.10.7 comment=static-dns-for-dhcp name=\
    mbp-mark-dietzer.foxden.network
add address=::ffff:10.2.10.7 comment=static-dns-for-dhcp name=\
    mbp-mark-dietzer.foxden.network type=AAAA
add address=10.2.12.17 comment=static-dns-for-dhcp name=\
    august-connect-back-door-upper.foxden.network
add address=::ffff:10.2.12.17 comment=static-dns-for-dhcp name=\
    august-connect-back-door-upper.foxden.network type=AAAA
add address=10.2.13.18 comment=static-dns-for-dhcp name=\
    uplift-dori-desk.foxden.network
add address=::ffff:10.2.13.18 comment=static-dns-for-dhcp name=\
    uplift-dori-desk.foxden.network type=AAAA
add address=10.2.12.50 comment=static-dns-for-dhcp name=\
    amp-living-room-wifi.foxden.network
add address=::ffff:10.2.12.50 comment=static-dns-for-dhcp name=\
    amp-living-room-wifi.foxden.network type=AAAA
add address=10.2.12.19 comment=static-dns-for-dhcp name=\
    nanoleaf-lines-wizzy.foxden.network
add address=::ffff:10.2.12.19 comment=static-dns-for-dhcp name=\
    nanoleaf-lines-wizzy.foxden.network type=AAAA
add address=10.2.12.20 comment=static-dns-for-dhcp name=\
    nanoleaf-shapes-dori.foxden.network
add address=::ffff:10.2.12.20 comment=static-dns-for-dhcp name=\
    nanoleaf-shapes-dori.foxden.network type=AAAA
add address=10.2.14.5 comment=static-dns-for-dhcp name=\
    dori-ipad.foxden.network
add address=::ffff:10.2.14.5 comment=static-dns-for-dhcp name=\
    dori-ipad.foxden.network type=AAAA
add address=10.1.10.11 comment=static-dns-for-dhcp name=\
    ap-living-room.foxden.network
add address=::ffff:10.1.10.11 comment=static-dns-for-dhcp name=\
    ap-living-room.foxden.network type=AAAA
add address=10.2.14.6 comment=static-dns-for-dhcp name=\
    dori-remarkable.foxden.network
add address=::ffff:10.2.14.6 comment=static-dns-for-dhcp name=\
    dori-remarkable.foxden.network type=AAAA
add address=10.2.10.8 comment=static-dns-for-dhcp name=\
    thunderbolt-10g.foxden.network
add address=::ffff:10.2.10.8 comment=static-dns-for-dhcp name=\
    thunderbolt-10g.foxden.network type=AAAA
add address=10.2.13.9 comment=static-dns-for-dhcp name=\
    custom-filament-dryer.foxden.network
add address=::ffff:10.2.13.9 comment=static-dns-for-dhcp name=\
    custom-filament-dryer.foxden.network type=AAAA
add address=10.2.12.21 comment=static-dns-for-dhcp name=\
    laundry-washer.foxden.network
add address=::ffff:10.2.12.21 comment=static-dns-for-dhcp name=\
    laundry-washer.foxden.network type=AAAA
add address=10.2.12.22 comment=static-dns-for-dhcp name=\
    laundry-dryer.foxden.network
add address=::ffff:10.2.12.22 comment=static-dns-for-dhcp name=\
    laundry-dryer.foxden.network type=AAAA
/ip firewall filter
add action=fasttrack-connection chain=forward comment="related, established" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment="related, established" \
    connection-state=established,related
add action=accept chain=forward comment="dstnat'd" connection-nat-state=\
    dstnat
add action=accept chain=forward out-interface-list=zone-wan
add action=accept chain=forward in-interface=wg-vpn
add action=accept chain=forward in-interface=oob
add action=accept chain=forward disabled=yes in-interface-list=iface-mgmt
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
add action=reject chain=forward disabled=yes log=yes reject-with=\
    icmp-admin-prohibited
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
add action=accept chain=input connection-state=established,related
add action=accept chain=input protocol=icmp
add action=accept chain=input comment="HTTP(S)" disabled=yes dst-port=80,443 \
    protocol=tcp
add action=accept chain=input comment=WireGuard dst-port=13231-13232 \
    protocol=udp
add action=accept chain=input in-interface=oob
add action=accept chain=input in-interface-list=zone-local
add action=reject chain=input reject-with=icmp-admin-prohibited
/ip firewall nat
add action=masquerade chain=srcnat out-interface=wan
add action=dst-nat chain=dstnat comment=Plex dst-port=32400 protocol=tcp \
    to-addresses=10.2.11.3
add action=dst-nat chain=dstnat comment="SpaceAge GMod" disabled=yes \
    dst-port=27015 protocol=udp to-addresses=10.3.10.4
add action=dst-nat chain=dstnat comment=Factorio dst-port=34197 protocol=udp \
    to-addresses=10.3.10.7
add action=dst-nat chain=dstnat comment=Plex dst-port=32400 protocol=tcp \
    to-addresses=10.2.11.3
add action=dst-nat chain=dstnat comment="SpaceAge GMod" dst-port=27015 \
    protocol=udp to-addresses=10.3.10.4
add action=dst-nat chain=dstnat comment=Factorio dst-port=34197 protocol=udp \
    to-addresses=10.3.10.7
/ip route
add disabled=no distance=10 dst-address=0.0.0.0/0 gateway=10.1.0.1 pref-src=\
    "" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip service
set telnet address=10.0.0.0/8,192.168.88.0/24 disabled=yes
set ftp address=10.0.0.0/8,192.168.88.0/24 disabled=yes
set www address=10.0.0.0/8,192.168.88.0/24 disabled=yes
set ssh address=10.0.0.0/8,192.168.88.0/24,127.0.0.0/8
set www-ssl address=10.0.0.0/8,192.168.88.0/24
set api address=10.0.0.0/8,192.168.88.0/24,127.0.0.0/8 disabled=yes
set winbox address=10.0.0.0/8,192.168.88.0/24,127.0.0.0/8
set api-ssl address=10.0.0.0/8,192.168.88.0/24 disabled=yes
/ipv6 address
add address=2a0e:7d44:f000:a::2 advertise=no interface=6to4-redfox
# duplicate address detected
add address=2a0e:7d44:f069:1::1 interface=vlan-mgmt
# duplicate address detected
add address=2a0e:7d44:f069:2::1 interface=vlan-lan
# duplicate address detected
add address=2a0e:7d44:f069:3::1 interface=vlan-dmz
# duplicate address detected
add address=2a0e:7d44:f069:4::1 interface=vlan-labnet
# duplicate address detected
add address=2a0e:7d44:f069:5::1 interface=vlan-security
# duplicate address detected
add address=2a0e:7d44:f069:6::1 interface=vlan-hypervisor
/ipv6 firewall filter
add action=accept chain=forward connection-state=established,related
add action=accept chain=forward protocol=icmpv6
add action=accept chain=forward in-interface=wg-vpn
add action=accept chain=forward in-interface=oob
add action=accept chain=forward in-interface-list=iface-mgmt
add action=accept chain=forward out-interface-list=zone-wan
add action=accept chain=forward out-interface-list=iface-dmz
add action=reject chain=forward reject-with=icmp-admin-prohibited
add action=accept chain=input connection-state=established,related
add action=accept chain=input protocol=icmpv6
add action=accept chain=input comment="HTTP(S)" dst-port=80,443 protocol=tcp
add action=accept chain=input comment=WireGuard dst-port=13231-13232 \
    protocol=udp
add action=accept chain=input in-interface=oob
add action=accept chain=input in-interface-list=zone-local
add action=reject chain=input reject-with=icmp-admin-prohibited
/ipv6 nd
set [ find default=yes ] advertise-dns=no mtu=9000
/snmp
set contact=admin@foxden.network enabled=yes location="Server room" \
    trap-generators=""
/system clock
set time-zone-autodetect=no time-zone-name=America/Los_Angeles
/system identity
set name=router-backup
/system ntp client
set enabled=yes
/system ntp server
set enabled=yes
/system ntp client servers
add address=10.1.1.2
add address=0.pool.ntp.org
add address=1.pool.ntp.org
add address=2.pool.ntp.org
add address=3.pool.ntp.org
/system scheduler
add interval=5m name=dyndns-update on-event=\
    "/system script run dyndns-update" policy=read,test start-date=\
    aug/09/2020 start-time=09:43:30
add interval=5m name=ipv6tun-update on-event=\
    "/system script run ipv6tun-update" policy=read,test start-date=\
    aug/09/2020 start-time=09:45:30
add disabled=yes interval=30s name=pingcheck on-event=\
    "/system script run pingcheck" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=dec/03/2020 start-time=00:00:00
add interval=5m name=redfoxv6-up on-event="/system script run redfoxv6-up" \
    policy=read,test start-date=aug/09/2020 start-time=09:47:30
add name=init-onboot on-event=\
    ":global VRRPPriorityOnline 25\r\
    \n:global VRRPPriorityOffline 5\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=1m name=vrrp-priority-adjust on-event=\
    "/system/script/run vrrp-priority-adjust\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=jan/17/2023 start-time=19:52:12
/system script
add dont-require-permissions=no name=dhcp-propagate-changes owner=admin \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source=":local topdomain\r\
    \n:local hostname\r\
    \n:local dhcpent\r\
    \n\r\
    \n:set topdomain \"foxden.network\"\r\
    \n\r\
    \n:put \"Adjusting lease times\"\r\
    \n/ip/dhcp-server/lease set [/ip/dhcp-server/lease find dynamic=no] lease-\
    time=1d\r\
    \n\r\
    \n:put \"Removing old DNS records\"\r\
    \n/ip/dns/static/remove [/ip/dns/static/find comment=\"static-dns-for-dhcp\
    \"]\r\
    \n\r\
    \n:put \"Adding new DNS records\"\r\
    \n:foreach i in=[/ip/dhcp-server/lease/find comment dynamic=no] do={\r\
    \n    :set dhcpent [/ip/dhcp-server/lease/get \$i]\r\
    \n    :set hostname ((\$dhcpent->\"comment\") . \".\" . \$topdomain)\r\
    \n\r\
    \n    :put (\"Adding: \" . \$hostname . \" : \" . (\$dhcpent->\"address\")\
    )\r\
    \n    /ip/dns/static/add type=A name=\$hostname address=(\$dhcpent->\"addr\
    ess\") comment=\"static-dns-for-dhcp\"\r\
    \n    /ip/dns/static/add type=AAAA name=\$hostname address=(\"::ffff:\" . \
    (\$dhcpent->\"address\")) comment=\"static-dns-for-dhcp\"\r\
    \n}\r\
    \n"
add dont-require-permissions=yes name=dyndns-update owner=admin policy=\
    read,test source=":local ddnshost \"router.dyn.foxden.network\"\r\
    \n:local key \"REMOVED\"\r\
    \n:local updatehost \"dyn.dns.he.net\"\r\
    \n\r\
    \n:local result [/tool/fetch mode=https url=\"https://\$updatehost/nic/upd\
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
    \n:local result [/tool/fetch mode=https url=\"https://\$updatehost/nic/upd\
    ate\?hostname=\$ddnshost\" user=\"\$user\" password=\"\$key\" as-value out\
    put=user]\r\
    \n:log debug (\$result->\"data\")\r\
    \n"
add dont-require-permissions=yes name=redfoxv6-update owner=admin policy=\
    read,test source=":local ipaddr [/ip/address/get [ /ip/address/find  inter\
    face=wan ] address]\r\
    \n\r\
    \n:local result [/tool fetch mode=https url=\"http://10.99.10.1:9999/updat\
    e-ip\?ip=\$ipaddr\" as-value output=user]\r\
    \n:log debug (\$result->\"data\")\r\
    \n"
add dont-require-permissions=no name=dhcp-mac-checker owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local dhcpent\r\
    \n:local arpmac\r\
    \n:local arpfind\r\
    \n\r\
    \n:foreach i in=[/ip/dhcp-server/lease/find status!=bound dynamic=no] do={\
    \r\
    \n    :set dhcpent [/ip/dhcp-server/lease/get \$i]\r\
    \n\r\
    \n    {\r\
    \n        :local jobID [:execute {:ping count=5 address=(\$dhcpent->\"addr\
    ess\")}]\r\
    \n        :while ([:len [/system/script/job/find .id=\$jobID]] > 0) do={\r\
    \n            :set arpfind [/ip/arp/find address=(\$dhcpent->\"address\") \
    mac-address!=\"\"]\r\
    \n            if ([:len \$arpfind] > 0) do={\r\
    \n                /system/script/job/remove [ /system/script/job/find .id=\
    \$jobID ]\r\
    \n            } else={\r\
    \n                :delay 1s\r\
    \n            }\r\
    \n        }\r\
    \n\r\
    \n        if ([:len \$arpfind] = 0) do={\r\
    \n            :set arpfind [/ip/arp/find address=(\$dhcpent->\"address\") \
    mac-address!=\"\"]\r\
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
    \n        :put (\"# IP: \" . (\$dhcpent->\"address\") . \" | DHCP MAC: \" \
    . (\$dhcpent->\"mac-address\") . \" | ARP MAC: \" . \$arpmac . \" | Commen\
    t: \" . (\$dhcpent->\"comment\"))\r\
    \n        :if (\$arpmac != \"N/A\") do={\r\
    \n            :put (\"/ip/dhcp-server/lease set [/ip/dhcp-server/lease fin\
    d address=\" . (\$dhcpent->\"address\") . \"] mac-address=\" . \$arpmac)\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n"
add dont-require-permissions=yes name=vrrp-priority-adjust owner=admin \
    policy=read,write,test source=":global VRRPPriorityOffline\r\
    \n:global VRRPPriorityOnline\r\
    \n:local VRRPPriorityCurrent \$VRRPPriorityOffline\r\
    \n\r\
    \n:local defgwidx [ /ip/route/find dynamic active dst-address=0.0.0.0/0 ]\
    \r\
    \n\r\
    \nif ([:len \$defgwidx] > 0) do={\r\
    \n    :local defgw [ /ip/route/get (\$defgwidx->0) gateway ]\r\
    \n    :local status [ /tool/netwatch/get [ /tool/netwatch/find comment=\"m\
    onitor-default\" ] status ]\r\
    \n    if (\$status = \"up\") do={\r\
    \n        :set VRRPPriorityCurrent \$VRRPPriorityOnline\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:put \"Set VRRP priority \$VRRPPriorityCurrent\"\r\
    \n/interface/vrrp set [ /interface/vrrp/find priority!=\$VRRPPriorityCurre\
    nt ] priority=\$VRRPPriorityCurrent\r\
    \n"
/tool netwatch
add comment=monitor-default disabled=no down-script=\
    "/system/script/run vrrp-priority-adjust\r\
    \n" host=8.8.8.8 http-codes="" interval=30s test-script="" timeout=1s \
    type=icmp up-script="/system/script/run vrrp-priority-adjust\r\
    \n"
