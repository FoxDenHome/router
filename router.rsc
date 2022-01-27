# jan/26/2022 23:12:35 by RouterOS 7.1.1
# software id = H573-DR9T
#
# model = RB5009UG+S+
# serial number = EC1A0F65067E
/interface bridge
add igmp-snooping=yes mtu=9000 name=br-network vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] l2mtu=9014 mtu=9000 name=eth1-mtik
set [ find default-name=ether2 ] name=eth2-lte
set [ find default-name=ether3 ] l2mtu=9014 mtu=9000 name=eth3
set [ find default-name=ether4 ] l2mtu=9014 mtu=9000 name=eth4
set [ find default-name=ether5 ] l2mtu=9014 mtu=9000 name=eth5
set [ find default-name=ether6 ] advertise=1000M-full l2mtu=9014 mtu=9000 \
    name=eth6
set [ find default-name=ether7 ] advertise=1000M-full l2mtu=9014 mtu=9000 \
    name=eth7
set [ find default-name=ether8 ] name=eth8-wan
set [ find default-name=sfp-sfpplus1 ] l2mtu=9014 mtu=9000 name=\
    sfp-rackswitch-agg
/interface 6to4
add comment="HE 2001:470:ea41::/48" !keepalive name=sit1-he remote-address=\
    216.218.226.238
/interface vrrp
add interface=br-network mtu=9000 name=vrrp-dns-mgmt priority=50 version=2 \
    vrid=53
add interface=br-network mtu=9000 name=vrrp-gateway-mgmt priority=50 version=\
    2
add interface=br-network mtu=9000 name=vrrp-ntp-mgmt priority=50 version=2 \
    vrid=123
/interface wireguard
add listen-port=13231 mtu=1420 name=wg-vpn
/interface vlan
add interface=br-network mtu=9000 name=vlan-dmz vlan-id=3
add interface=br-network mtu=9000 name=vlan-lab vlan-id=4
add interface=br-network mtu=9000 name=vlan-lan vlan-id=2
add interface=br-network mtu=9000 name=vlan-security vlan-id=5
/interface vrrp
add interface=vlan-dmz mtu=9000 name=vrrp-dns-dmz priority=50 version=2 vrid=\
    53
add interface=vlan-lab mtu=9000 name=vrrp-dns-lab priority=50 version=2 vrid=\
    53
add interface=vlan-lan mtu=9000 name=vrrp-dns-lan priority=50 version=2 vrid=\
    53
add interface=vlan-security mtu=9000 name=vrrp-dns-security priority=50 \
    version=2 vrid=53
add interface=vlan-dmz mtu=9000 name=vrrp-gateway-dmz priority=50 version=2
add interface=vlan-lab mtu=9000 name=vrrp-gateway-lab priority=50 version=2
add interface=vlan-lan mtu=9000 name=vrrp-gateway-lan priority=50 version=2
add interface=vlan-security mtu=9000 name=vrrp-gateway-security priority=50 \
    version=2
add interface=vlan-dmz mtu=9000 name=vrrp-ntp-dmz priority=50 version=2 vrid=\
    123
add interface=vlan-lab mtu=9000 name=vrrp-ntp-lab priority=50 version=2 vrid=\
    123
add interface=vlan-lan mtu=9000 name=vrrp-ntp-lan priority=50 version=2 vrid=\
    123
add interface=vlan-security mtu=9000 name=vrrp-ntp-security priority=50 \
    version=2 vrid=123
/interface list
add name=lan-ifaces
add name=mgmt-ifaces
add name=dmz-ifaces
add name=vpn-ifaces
add name=wan-ifaces
add name=lte-ifaces
add name=lab-ifaces
add name=accedian-ifaces
add name=security-ifaces
add name=lldp-list
/interface lte apn
set [ find default=yes ] default-route-distance=20 use-peer-dns=no
add apn=fast.t-mobile.com default-route-distance=20 name=tmobile \
    use-peer-dns=no
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
add name=lan-pool ranges=10.2.128.1-10.2.255.254
add name=dmz-pool ranges=10.3.128.1-10.3.255.254
add name=mgmt-pool ranges=10.1.128.1-10.1.255.254
add name=lab-pool ranges=10.4.128.1-10.4.255.254
add name=security-pool ranges=10.5.128.1-10.5.255.254
/ip dhcp-server
add address-pool=lan-pool dhcp-option-set=default-noclassless interface=\
    vlan-lan lease-time=10h name=lan-dhcp
add address-pool=dmz-pool dhcp-option-set=default-classless interface=\
    vlan-dmz lease-time=10h name=dmz-dhcp
add address-pool=mgmt-pool dhcp-option-set=default-classless interface=\
    br-network lease-time=10h name=mgmt-dhcp
add address-pool=lab-pool dhcp-option-set=default-classless interface=\
    vlan-lab lease-time=10h name=lab-dhcp
add address-pool=security-pool dhcp-option-set=default-classless interface=\
    vlan-security lease-time=10h name=security-dhcp
/ipv6 pool
add name=pool-he prefix=2001:470:ea41::/48 prefix-length=64
/port
set 0 baud-rate=115200 name=usb2
/routing bgp template
set default disabled=no output.network=bgp-networks
/routing table
add disabled=no fib name=force-lte
add disabled=no fib name=force-wired
/snmp community
set [ find default=yes ] disabled=yes
add addresses=::/0 name=monitor_TqmX0b
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp,rest-api"
/interface bridge port
add bridge=br-network interface=eth7
add bridge=br-network interface=eth3
add bridge=br-network interface=eth4
add bridge=br-network interface=sfp-rackswitch-agg
add bridge=br-network interface=eth5
add bridge=br-network interface=eth6
/ip neighbor discovery-settings
set discover-interface-list=lldp-list
/ip settings
set max-neighbor-entries=8192 secure-redirects=no tcp-syncookies=yes
/ipv6 settings
set accept-redirects=no accept-router-advertisements=no max-neighbor-entries=\
    8192
/interface bridge vlan
add bridge=br-network untagged=br-network,sfp-rackswitch-agg vlan-ids=1
add bridge=br-network tagged=br-network,sfp-rackswitch-agg vlan-ids=4
add bridge=br-network tagged=br-network,sfp-rackswitch-agg vlan-ids=2
add bridge=br-network tagged=br-network,sfp-rackswitch-agg vlan-ids=3
add bridge=br-network tagged=br-network,sfp-rackswitch-agg vlan-ids=5
/interface list member
add interface=sit1-he list=wan-ifaces
add interface=wg-vpn list=vpn-ifaces
add interface=br-network list=mgmt-ifaces
add interface=vlan-lan list=lan-ifaces
add interface=vrrp-dns-lan list=lan-ifaces
add interface=vrrp-gateway-lan list=lan-ifaces
add interface=vlan-dmz list=dmz-ifaces
add interface=vrrp-dns-dmz list=dmz-ifaces
add interface=vrrp-gateway-dmz list=dmz-ifaces
add interface=vlan-lab list=lab-ifaces
add interface=vrrp-dns-lab list=lab-ifaces
add interface=vrrp-gateway-lab list=lab-ifaces
add interface=vrrp-dns-mgmt list=mgmt-ifaces
add interface=vrrp-gateway-mgmt list=mgmt-ifaces
add interface=vlan-security list=security-ifaces
add interface=vrrp-gateway-security list=security-ifaces
add interface=vrrp-dns-security list=security-ifaces
add interface=eth2-lte list=lte-ifaces
add interface=eth8-wan list=wan-ifaces
add interface=sfp-rackswitch-agg list=lldp-list
add interface=eth8-wan list=lldp-list
/interface wireguard peers
add allowed-address=10.100.10.1/32 comment=fennec interface=wg-vpn \
    public-key="7wBo2+Q88MPXKi2OYZsyDyl16wldEsIeWycng57Jx3A="
add allowed-address=10.100.10.3/32 comment="dori phone" interface=wg-vpn \
    public-key="keEyvK/AutdYbAYkkXffsvGEOCKZjlp6A0gDBsI8F0g="
add allowed-address=10.100.10.2/32 comment=capefox interface=wg-vpn \
    public-key="jay5WNfSd0Wo5k+FMweulWnaoxm1I82gom7JNkEjUBs="
add allowed-address=10.100.11.1/32 comment=redfox endpoint-address=\
    redfox.doridian.net endpoint-port=13231 interface=wg-vpn \
    persistent-keepalive=2m public-key=\
    "yY6nKPCqcj+0O6Sm7qcBlG7O5tyQlarlZFIKjp+ivGM="
/ip address
add address=192.168.88.10/24 interface=eth1-mtik network=192.168.88.0
add address=10.101.10.2/24 interface=eth2-lte network=10.101.10.0
add address=10.1.1.1/16 interface=br-network network=10.1.0.0
add address=10.2.1.1/16 interface=vlan-lan network=10.2.0.0
add address=10.3.1.1/16 interface=vlan-dmz network=10.3.0.0
add address=10.5.1.1/16 interface=vlan-security network=10.5.0.0
add address=10.4.1.1/16 interface=vlan-lab network=10.4.0.0
add address=10.1.0.53 interface=vrrp-dns-mgmt network=10.1.0.53
add address=10.1.0.1 interface=vrrp-gateway-mgmt network=10.1.0.1
add address=10.3.0.53 interface=vrrp-dns-dmz network=10.3.0.53
add address=10.2.0.53 interface=vrrp-dns-lan network=10.2.0.53
add address=10.4.0.53 interface=vrrp-dns-lab network=10.4.0.53
add address=10.5.0.53 interface=vrrp-dns-security network=10.5.0.53
add address=10.3.0.1 interface=vrrp-gateway-dmz network=10.3.0.1
add address=10.2.0.1 interface=vrrp-gateway-lan network=10.2.0.1
add address=10.4.0.1 interface=vrrp-gateway-lab network=10.4.0.1
add address=10.5.0.1 interface=vrrp-gateway-security network=10.5.0.1
add address=10.100.0.1/16 interface=wg-vpn network=10.100.0.0
add address=10.1.0.123 interface=vrrp-ntp-mgmt network=10.1.0.123
add address=10.2.0.123 interface=vrrp-ntp-lan network=10.2.0.123
add address=10.3.0.123 interface=vrrp-ntp-dmz network=10.3.0.123
add address=10.4.0.123 interface=vrrp-ntp-lab network=10.4.0.123
add address=10.5.0.123 interface=vrrp-ntp-security network=10.5.0.123
/ip cloud
set update-time=no
/ip dhcp-client
add default-route-distance=20 interface=eth2-lte use-peer-dns=no \
    use-peer-ntp=no
add default-route-distance=15 interface=eth8-wan script="#/system script run d\
    yndns-update\r\
    \n#/system script run ipv6tun-update\r\
    \n" use-peer-dns=no use-peer-ntp=no
/ip dhcp-server lease
add address=10.2.10.3 comment=capefox-wireless dhcp-option=classless \
    mac-address=F0:2F:4B:14:84:F4 server=lan-dhcp
add address=10.2.10.4 comment=capefox-wired dhcp-option=classless \
    mac-address=00:30:93:12:12:38 server=lan-dhcp
add address=10.1.12.1 comment=islandfox mac-address=B8:AE:ED:7C:1E:71 server=\
    mgmt-dhcp
add address=10.2.10.1 comment=fennec dhcp-option=classless mac-address=\
    7C:FE:90:AB:B5:00 server=lan-dhcp
add address=10.2.11.1 comment=nas dhcp-option=classless mac-address=\
    00:0C:29:C6:9A:DC server=lan-dhcp
add address=10.2.10.2 comment=wizzy-desktop dhcp-option=classless \
    mac-address=EC:0D:9A:21:DF:70 server=lan-dhcp
add address=10.1.12.3 comment=bengalfox mac-address=00:25:90:9C:16:AE server=\
    mgmt-dhcp
add address=10.1.12.2 comment=bengalfox-ipmi mac-address=00:25:90:6D:05:12 \
    server=mgmt-dhcp
add address=10.1.10.4 comment=switch-living-room mac-address=\
    80:2A:A8:DE:F0:AE server=mgmt-dhcp
add address=10.1.11.1 comment=pdu-rack mac-address=00:06:67:41:F2:78 server=\
    mgmt-dhcp
add address=10.1.10.2 comment=switch-rack mac-address=24:5A:4C:A6:6B:9A \
    server=mgmt-dhcp
add address=10.1.10.3 comment=switch-rack-agg mac-address=24:5A:4C:56:41:C4 \
    server=mgmt-dhcp
add address=10.1.11.2 comment=ups-rack mac-address=00:C0:B7:E8:B2:A0 server=\
    mgmt-dhcp
add address=10.1.10.1 comment=unifi mac-address=24:5A:4C:8A:23:3F server=\
    mgmt-dhcp
add address=10.1.10.6 comment=ap-living-room mac-address=68:D7:9A:1F:57:E2 \
    server=mgmt-dhcp
add address=10.1.10.5 comment=switch-workbench mac-address=74:83:C2:FF:87:16 \
    server=mgmt-dhcp
add address=10.1.13.1 comment=telegraf mac-address=00:50:56:2E:16:A0 server=\
    mgmt-dhcp
add address=10.2.11.2 comment=syncthing dhcp-option=classless mac-address=\
    02:42:C0:A8:04:15 server=lan-dhcp
add address=10.1.11.3 comment=ups-office mac-address=00:0C:15:04:39:93 \
    server=mgmt-dhcp
add address=10.1.11.4 comment=ups-rack-backup mac-address=00:C0:B7:E8:AE:82 \
    server=mgmt-dhcp
add address=10.4.10.1 comment=cr6se mac-address=B8:27:EB:ED:0F:4B server=\
    lab-dhcp
add address=10.2.12.3 comment=printer mac-address=E8:D8:D1:79:F5:98 server=\
    lan-dhcp
add address=10.2.12.1 comment=hue mac-address=00:17:88:AC:31:4B server=\
    lan-dhcp
add address=10.2.12.2 comment=homeassistant mac-address=E4:5F:01:62:2D:8E \
    server=lan-dhcp
add address=10.5.10.1 client-id=1:68:d7:9a:cf:30:9 comment=camera-living-room \
    mac-address=68:D7:9A:CF:30:09 server=security-dhcp
add address=10.2.11.3 comment=plex dhcp-option=classless mac-address=\
    02:42:C0:A8:04:16 server=lan-dhcp
add address=10.2.11.4 comment=prometheus dhcp-option=classless mac-address=\
    02:42:C0:A8:04:17 server=lan-dhcp
add address=10.2.11.5 comment=grafana dhcp-option=classless mac-address=\
    02:42:C0:A8:04:18 server=lan-dhcp
add address=10.2.11.6 comment=kiwix dhcp-option=classless mac-address=\
    02:42:C0:A8:04:19 server=lan-dhcp
add address=10.3.10.6 comment=dldr dhcp-option=classless mac-address=\
    02:42:C0:A8:04:20 server=dmz-dhcp
add address=10.2.12.7 comment=clock-nixie-zen mac-address=E0:4F:43:C2:BA:C2 \
    server=lan-dhcp
add address=10.2.13.7 comment=airgradient-bedroom mac-address=\
    AC:0B:FB:D0:2A:63 server=lan-dhcp
add address=10.2.13.6 comment=airgradient-living-room mac-address=\
    AC:0B:FB:D0:7B:5B server=lan-dhcp
add address=10.2.13.5 comment=airgradient-office mac-address=\
    AC:0B:FB:CF:99:15 server=lan-dhcp
add address=10.2.12.9 comment=vacuum-neato mac-address=40:BD:32:95:26:C0 \
    server=lan-dhcp
add address=10.2.12.4 comment=homepod-living-room mac-address=\
    F4:34:F0:4B:87:1A server=lan-dhcp
add address=10.2.12.5 comment=homepod-bedroom mac-address=94:EA:32:84:DB:90 \
    server=lan-dhcp
add address=10.2.14.1 comment=dori-phone mac-address=EA:46:D1:B8:10:11 \
    server=lan-dhcp
add address=10.2.12.6 comment=appletv-living-room mac-address=\
    58:D3:49:E4:02:2D server=lan-dhcp
add address=10.2.15.1 comment=nintendo-switch-wired mac-address=\
    00:0E:C6:D2:C9:DD server=lan-dhcp
add address=10.2.14.3 comment=wizzy-phone mac-address=56:6C:5E:7A:0E:C7 \
    server=lan-dhcp
add address=10.2.14.4 comment=wizzy-watch mac-address=2E:47:59:D7:CF:2D \
    server=lan-dhcp
add address=10.2.10.6 comment=wizzy-laptop-2 mac-address=88:66:5A:53:5E:40 \
    server=lan-dhcp
add address=10.2.10.5 comment=wizzy-laptop mac-address=F0:2F:4B:15:2E:54 \
    server=lan-dhcp
add address=10.2.12.10 comment=amp-living-room mac-address=EC:F4:51:D0:8C:AF \
    server=lan-dhcp
add address=10.2.12.8 comment=clock-nixie-office mac-address=\
    C4:5B:BE:63:3A:2E server=lan-dhcp
add address=10.2.14.2 comment=dori-watch mac-address=EA:49:8F:A3:91:E5 \
    server=lan-dhcp
add address=10.2.13.9 comment=custom-office-switcher mac-address=\
    58:BF:25:33:1F:68 server=lan-dhcp
add address=10.3.10.5 comment=spaceage-web mac-address=00:16:3E:CA:7E:30 \
    server=dmz-dhcp
add address=10.3.10.4 comment=spaceage-gmod mac-address=00:16:3E:CA:7E:31 \
    server=dmz-dhcp
add address=10.3.10.1 comment=foxcaves mac-address=00:16:3E:CA:7E:00 server=\
    dmz-dhcp
add address=10.2.13.4 comment=sonoff-s31-bedroom-fan mac-address=\
    8C:AA:B5:66:3B:BE server=lan-dhcp
add address=10.2.13.3 comment=sonoff-s31-cr6se mac-address=E8:DB:84:9F:4F:08 \
    server=lan-dhcp
add address=10.2.13.8 comment=sonoff-s31-dori-pc mac-address=\
    8C:AA:B5:66:3D:81 server=lan-dhcp
add address=10.2.13.2 comment=sonoff-s31-office-fan mac-address=\
    8C:AA:B5:66:12:00 server=lan-dhcp
add address=10.2.13.1 comment=sonoff-s31-simon-pc mac-address=\
    8C:AA:B5:66:10:70 server=lan-dhcp
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
/ip dns
set allow-remote-requests=yes cache-max-ttl=1h cache-size=40960KiB servers=\
    8.8.8.8,8.8.4.4 verify-doh-cert=yes
/ip dns static
add cname=ntp.foxden.network name=time.windows.com type=CNAME
add address=10.2.0.123 name=ntp.foxden.network
add address=10.2.1.1 name=vpn.foxden.network
add cname=spaceage-web.foxden.network name=spaceage.mp type=CNAME
add cname=spaceage-web.foxden.network name=static.spaceage.mp type=CNAME
add cname=spaceage-web.foxden.network name=forums.spaceage.mp type=CNAME
add cname=spaceage-web.foxden.network name=www.spaceage.mp type=CNAME
add cname=spaceage-web.foxden.network name=tts.spaceage.mp type=CNAME
add cname=spaceage-web.foxden.network name=api.spaceage.mp type=CNAME
add address=10.2.10.3 name=capefox-wireless.foxden.network
add address=10.2.10.4 name=capefox-wired.foxden.network
add address=10.1.12.1 name=islandfox.foxden.network
add address=10.2.10.1 name=fennec.foxden.network
add address=10.2.11.1 name=nas.foxden.network
add address=10.2.10.2 name=wizzy-desktop.foxden.network
add address=10.1.12.3 name=bengalfox.foxden.network
add address=10.1.12.2 name=bengalfox-ipmi.foxden.network
add address=10.1.10.4 name=switch-living-room.foxden.network
add address=10.1.11.1 name=pdu-rack.foxden.network
add address=10.1.10.2 name=switch-rack.foxden.network
add address=10.1.10.3 name=switch-rack-agg.foxden.network
add address=10.1.11.2 name=ups-rack.foxden.network
add address=10.1.10.1 name=unifi.foxden.network
add address=10.1.10.6 name=ap-living-room.foxden.network
add address=10.1.10.5 name=switch-workbench.foxden.network
add address=10.1.13.1 name=telegraf.foxden.network
add address=10.2.11.2 name=syncthing.foxden.network
add address=10.1.11.3 name=ups-office.foxden.network
add address=10.1.11.4 name=ups-rack-backup.foxden.network
add address=10.4.10.1 name=cr6se.foxden.network
add address=10.2.12.3 name=printer.foxden.network
add address=10.2.12.1 name=hue.foxden.network
add address=10.2.12.2 name=homeassistant.foxden.network
add address=10.5.10.1 name=camera-living-room.foxden.network
add address=10.2.11.3 name=plex.foxden.network
add address=10.2.11.4 name=prometheus.foxden.network
add address=10.2.11.5 name=grafana.foxden.network
add address=10.2.11.6 name=kiwix.foxden.network
add address=10.3.10.6 name=dldr.foxden.network
add address=10.2.13.8 name=sonoff-s31-dori-pc.foxden.network
add address=10.2.12.7 name=clock-nixie-zen.foxden.network
add address=10.2.13.7 name=airgradient-bedroom.foxden.network
add address=10.2.13.6 name=airgradient-living-room.foxden.network
add address=10.2.13.5 name=airgradient-office.foxden.network
add address=10.2.12.9 name=vacuum-neato.foxden.network
add address=10.2.13.4 name=sonoff-s31-bedroom-fan.foxden.network
add address=10.2.13.3 name=sonoff-s31-cr6se.foxden.network
add address=10.2.13.2 name=sonoff-s31-office-fan.foxden.network
add address=10.2.13.1 name=sonoff-s31-simon-pc.foxden.network
add address=10.2.12.4 name=homepod-living-room.foxden.network
add address=10.2.12.5 name=homepod-bedroom.foxden.network
add address=10.2.14.1 name=dori-phone.foxden.network
add address=10.2.12.6 name=appletv-living-room.foxden.network
add address=10.2.15.1 name=nintendo-switch-wired.foxden.network
add address=10.2.14.3 name=wizzy-phone.foxden.network
add address=10.2.14.4 name=wizzy-watch.foxden.network
add address=10.2.10.6 name=wizzy-laptop-2.foxden.network
add address=10.2.10.5 name=wizzy-laptop.foxden.network
add address=10.2.12.10 name=amp-living-room.foxden.network
add address=10.2.12.8 name=clock-nixie-office.foxden.network
add address=10.2.14.2 name=dori-watch.foxden.network
add address=10.2.13.9 name=custom-office-switcher.foxden.network
add address=10.3.10.5 name=spaceage-web.foxden.network
add address=10.3.10.4 name=spaceage-gmod.foxden.network
add address=10.3.10.1 name=foxcaves.foxden.network
add cname=foxcaves.foxden.network name=foxcav.es type=CNAME
add cname=foxcaves.foxden.network name=www.foxcav.es type=CNAME
add cname=foxcaves.foxden.network name=f0x.es type=CNAME
add cname=foxcaves.foxden.network name=www.f0x.es type=CNAME
/ip firewall address-list
add address=10.100.0.0/16 list=VPN
add address=192.168.0.0/16 list=LocalNet
add address=10.0.0.0/8 list=LocalNet
add address=172.16.0.0/12 list=LocalNet
add address=10.2.10.0/24 comment="LAN Computers" list=Allow-LTE
add address=10.2.12.0/24 comment="LAN IoT" list=Allow-LTE
add address=10.5.0.0/16 comment=Security list=Allow-LTE
add address=10.1.10.0/24 comment="MGMT Network" list=Allow-LTE
add address=10.2.10.4 comment="capefox wired" list=Forbid-LTE
add address=10.2.10.3 comment="capefox wired" list=Forbid-LTE
/ip firewall filter
add action=drop chain=forward in-interface-list=wan-ifaces \
    out-interface-list=wan-ifaces
add action=fasttrack-connection chain=forward comment="related, established" \
    connection-state=established,related hw-offload=yes protocol=tcp
add action=fasttrack-connection chain=forward comment="related, established" \
    connection-state=established,related hw-offload=yes protocol=udp
add action=accept chain=forward comment="related, established" \
    connection-state=established,related
add action=jump chain=forward jump-target=srccheck
add action=drop chain=forward comment="Block all multi/broad-cast on VPN" \
    dst-address-type=broadcast,multicast in-interface-list=vpn-ifaces
add action=drop chain=forward comment="Block all multi/broad-cast on VPN" \
    in-interface-list=vpn-ifaces src-address-type=broadcast,multicast
add action=accept chain=forward comment="VPN / WG" in-interface-list=\
    vpn-ifaces
add action=accept chain=forward comment="MGMT -> *" in-interface-list=\
    mgmt-ifaces
add action=jump chain=forward comment=MGMT jump-target=mgmt-out \
    out-interface-list=mgmt-ifaces
add action=accept chain=forward comment="DMZ Allow All" out-interface-list=\
    dmz-ifaces
add action=jump chain=forward comment=LAN jump-target=lan-out \
    out-interface-list=lan-ifaces
add action=jump chain=forward comment=Lab jump-target=lab-out \
    out-interface-list=lab-ifaces
add action=jump chain=forward comment=Security jump-target=security-out \
    out-interface-list=security-ifaces
add action=jump chain=forward comment=LTE jump-target=lte-out \
    out-interface-list=lte-ifaces
add action=accept chain=forward comment=WAN out-interface-list=wan-ifaces
add action=drop chain=forward
add action=accept chain=mgmt-out comment="Prometheus -> NodeExporter" \
    dst-port=9100 in-interface-list=lan-ifaces protocol=tcp src-address=\
    10.2.11.4
add action=accept chain=mgmt-out comment="Security -> unifi" dst-address=\
    10.1.10.1 in-interface-list=security-ifaces
add action=accept chain=mgmt-out comment="LAN -> unifi" dst-address=10.1.10.1 \
    in-interface-list=lan-ifaces
add action=accept chain=lan-out comment=homeassistant dst-address=10.2.12.2 \
    dst-port=80,8123,443 protocol=tcp
add action=accept chain=lan-out comment=plex dst-address=10.2.11.3 dst-port=\
    32400 protocol=tcp
add action=accept chain=lan-out comment=nas dst-address=10.2.11.1 dst-port=\
    22,8888 protocol=tcp
add action=accept chain=lan-out comment="IoT -> LAN (3722/udp)" dst-port=3722 \
    in-interface-list=*2000012 protocol=udp
add action=accept chain=lan-out comment="LAN -> LAN" in-interface-list=\
    lan-ifaces
add action=accept chain=tor-out comment="LAN -> Tor" in-interface-list=\
    lan-ifaces
add action=accept chain=lte-out dst-address=10.101.10.0/24
add action=drop chain=lte-out src-address-list=Forbid-LTE
add action=accept chain=lte-out src-address-list=Allow-LTE
add action=drop chain=lte-out
add action=return chain=srccheck in-interface-list=mgmt-ifaces src-address=\
    10.1.0.0/16
add action=return chain=srccheck in-interface-list=lan-ifaces src-address=\
    10.2.0.0/16
add action=return chain=srccheck in-interface-list=dmz-ifaces src-address=\
    10.3.0.0/16
add action=return chain=srccheck in-interface-list=lab-ifaces src-address=\
    10.4.0.0/16
add action=return chain=srccheck in-interface-list=security-ifaces \
    src-address=10.5.0.0/16
add action=return chain=srccheck in-interface-list=vpn-ifaces src-address=\
    10.100.0.0/16
add action=return chain=srccheck in-interface-list=lte-ifaces src-address=\
    10.101.10.0/24
add action=return chain=srccheck in-interface=eth1-mtik src-address=\
    192.168.88.0/24
add action=return chain=srccheck in-interface-list=wan-ifaces \
    src-address-list=!LocalNet
add action=drop chain=srccheck
add action=accept chain=input in-interface-list=mgmt-ifaces
add action=accept chain=input in-interface-list=vpn-ifaces
add action=accept chain=input connection-state=established,related
add action=accept chain=input comment=DHCP dst-port=67,68 protocol=udp
add action=accept chain=input comment=WireGuard dst-port=13231 protocol=udp
add action=accept chain=input comment="ssh, winbox" dst-port=22,8291 \
    in-interface-list=lan-ifaces protocol=tcp
add action=accept chain=input protocol=icmp
add action=drop chain=input in-interface-list=wan-ifaces
add action=accept chain=input comment=DNS dst-port=53 protocol=udp
add action=accept chain=input comment=NTP dst-port=123 protocol=udp
add action=accept chain=input protocol=igmp
add action=accept chain=input protocol=vrrp
add action=drop chain=input
add action=accept chain=output
/ip firewall mangle
add action=change-ttl chain=postrouting new-ttl=set:65 out-interface-list=\
    lte-ifaces passthrough=yes
add action=mark-routing chain=prerouting dst-address=10.101.11.1 \
    new-routing-mark=force-wired passthrough=yes
add action=mark-routing chain=prerouting dst-address=10.101.11.2 \
    new-routing-mark=force-lte passthrough=yes
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=wan-ifaces
add action=masquerade chain=srcnat out-interface-list=lte-ifaces
add action=dst-nat chain=dstnat comment=plex dst-port=32400 \
    in-interface-list=wan-ifaces protocol=tcp to-addresses=10.2.11.3
add action=dst-nat chain=dstnat comment=nas dst-port=8888 in-interface-list=\
    wan-ifaces protocol=tcp to-addresses=10.2.11.1 to-ports=8888
add action=dst-nat chain=dstnat comment="nas ssh" dst-port=2222 \
    in-interface-list=wan-ifaces protocol=tcp to-addresses=10.2.11.1 \
    to-ports=22
add action=dst-nat chain=dstnat comment=gmod dst-port=27015 \
    in-interface-list=wan-ifaces protocol=udp to-addresses=10.3.10.4
add action=dst-nat chain=dstnat comment=ut2004 dst-port=7777-7778 \
    in-interface-list=wan-ifaces protocol=udp to-addresses=10.3.10.3
add action=dst-nat chain=dstnat dst-address=10.101.11.1 routing-mark=\
    force-wired to-addresses=8.8.8.8
add action=dst-nat chain=dstnat dst-address=10.101.11.2 routing-mark=\
    force-lte to-addresses=8.8.8.8
/ip route
add blackhole disabled=no dst-address=10.0.0.0/8
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=eth2-lte pref-src="" \
    routing-table=force-lte scope=30 suppress-hw-offload=no target-scope=10
add disabled=no dst-address=0.0.0.0/0 gateway=eth8-wan routing-table=\
    force-wired suppress-hw-offload=no
add blackhole disabled=no distance=1 dst-address=192.168.0.0/16 gateway="" \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add blackhole disabled=no distance=10 dst-address=0.0.0.0/0 gateway="" \
    pref-src="" routing-table=force-lte scope=30 suppress-hw-offload=no \
    target-scope=10
add blackhole disabled=no distance=10 dst-address=0.0.0.0/0 gateway="" \
    pref-src="" routing-table=force-wired scope=30 suppress-hw-offload=no \
    target-scope=10
/ipv6 route
add check-gateway=ping comment=HE disabled=yes distance=5 dst-address=/0 \
    gateway=2001:470:a:5c2::1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ip smb shares
add comment="default share" directory=/pub name=pub
/ip smb users
add name=guest
/ip ssh
set always-allow-password-login=yes strong-crypto=yes
/ip upnp interfaces
add interface=eth7 type=external
/ipv6 address
add address=::1 from-pool=pool-wan interface=br-network
add address=::1 from-pool=pool-wan interface=vlan-dmz
add address=::1 from-pool=pool-wan
add address=::1 from-pool=pool-wan interface=vlan-lan
add address=2001:470:a:5c2::2 advertise=no interface=sit1-he
add address=2001:470:ea41::1 advertise=no interface=sit1-he
add address=::1 advertise=no from-pool=pool-wan interface=eth8-wan
/ipv6 dhcp-client
add add-default-route=yes default-route-distance=15 interface=eth8-wan \
    pool-name=pool-wan prefix-hint=::/56 request=prefix use-peer-dns=no
/ipv6 firewall address-list
add address=bengalfox.dyn.foxden.network disabled=yes list=bengalfox-dyndns
add address=nas.dyn.foxden.network disabled=yes list=nas-dyndns
add address=grafana.dyn.foxden.network disabled=yes list=grafana-dyndns
add address=ntp.dyn.foxden.network disabled=yes list=ntp-dyndns
add address=homeassistant.dyn.foxden.network list=homeassistant-dyndns
/ipv6 firewall filter
add action=drop chain=forward out-interface-list=*2000017
add action=drop chain=forward in-interface-list=*2000017
add action=drop chain=forward out-interface-list=lab-ifaces
add action=drop chain=forward in-interface-list=lab-ifaces
add action=drop chain=forward out-interface-list=security-ifaces
add action=drop chain=forward in-interface-list=security-ifaces
add action=drop chain=forward in-interface-list=wan-ifaces \
    out-interface-list=wan-ifaces
add action=accept chain=forward comment="related, established" \
    connection-state=established,related
add action=accept chain=forward connection-state=established,related \
    protocol=icmpv6
add action=accept chain=forward comment="VPN / WG" in-interface-list=\
    vpn-ifaces
add action=accept chain=forward comment="MGMT -> *" in-interface-list=\
    mgmt-ifaces
add action=jump chain=forward comment=MGMT jump-target=mgmt-out \
    out-interface-list=mgmt-ifaces
add action=accept chain=forward comment="DMZ Allow All" out-interface-list=\
    dmz-ifaces
add action=jump chain=forward comment=IoT jump-target=iot-out \
    out-interface-list=*2000012
add action=jump chain=forward comment=LAN jump-target=lan-out \
    out-interface-list=lan-ifaces
add action=accept chain=forward comment=WAN out-interface-list=wan-ifaces
add action=drop chain=forward
add action=accept chain=iot-out comment="plex 32400" disabled=yes \
    dst-address-list=plex-dyndns dst-port=32400 protocol=tcp
add action=accept chain=iot-out comment=homeassistant dst-address-list=\
    homeassistant-dyndns dst-port=80,443 protocol=tcp
add action=accept chain=iot-out comment="LAN -> IoT" in-interface-list=\
    lan-ifaces
add action=accept chain=tor-out comment="LAN -> Tor" in-interface-list=\
    lan-ifaces
add action=accept chain=input in-interface-list=mgmt-ifaces
add action=accept chain=input in-interface-list=vpn-ifaces
add action=accept chain=input connection-state=established,related
add action=accept chain=input comment=DHCPv6 dst-port=546,547 protocol=udp
add action=accept chain=input protocol=icmpv6
add action=accept chain=input comment=WireGuard dst-port=13231 protocol=udp
add action=drop chain=input in-interface-list=wan-ifaces
add action=accept chain=input comment=DNS dst-port=53 protocol=udp
add action=accept chain=input protocol=igmp
add action=drop chain=input
/ipv6 nd
set [ find default=yes ] advertise-dns=no
/ipv6 nd prefix default
set preferred-lifetime=15m valid-lifetime=3h
/routing filter rule
add chain=dynamic-in disabled=no rule="set gw-check icmp;"
/snmp
set contact=admin@foxden.network enabled=yes location=FoxDen trap-community=\
    monitor_TqmX0b trap-generators=""
/system clock
set time-zone-name=America/Los_Angeles
/system console
set [ find port=usb2 ] port=usb2
/system identity
set name=router
/system logging
add disabled=yes topics=debug
/system ntp client
set enabled=yes
/system ntp client servers
add address=10.1.1.2
/system routerboard settings
set cpu-frequency=auto
/system scheduler
add interval=5m name=dyndns-update on-event=\
    "/system script run dyndns-update" policy=read,test start-date=\
    aug/09/2020 start-time=09:41:00
add interval=5m name=ipv6tun-update on-event=\
    "/system script run ipv6tun-update" policy=read,test start-date=\
    aug/09/2020 start-time=09:43:00
add interval=30s name=pingcheck on-event="/system script run pingcheck" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=dec/03/2020 start-time=00:00:00
/system script
add dont-require-permissions=no name=static-dns-for-dhcp owner=doridian \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source="# DNS record for DHCP lease\r\
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
    \n    /ip dns static add name=\$hostname address=\$hostip;\r\
    \n  }\r\
    \n}"
add dont-require-permissions=yes name=dyndns-update owner=doridian policy=\
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
add dont-require-permissions=yes name=ipv6tun-update owner=doridian policy=\
    read,test source=":local ddnshost \"596328\"\r\
    \n:local user \"doridian\"\r\
    \n:local key \"REMOVED\"\r\
    \n:local updatehost \"ipv4.tunnelbroker.net\"\r\
    \n\r\
    \n:local result [/tool fetch mode=https url=\"https://\$updatehost/nic/upd\
    ate\?hostname=\$ddnshost\" user=\"\$user\" password=\"\$key\" as-value out\
    put=user]\r\
    \n:log debug (\$result->\"data\")\r\
    \n"
add dont-require-permissions=no name=pingcheck owner=doridian policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local ipPing \"8.8.8.8\"\
    \n:local pingCount 5\
    \n:local iface \"eth8-wan\"\
    \n\
    \n:local dhcplease\
    \n:set dhcplease [/ip dhcp-client find where interface=\$iface status=boun\
    d]\
    \n\
    \n:if (\$dhcplease) do={\
    \n    :local pingsok\
    \n    :set pingsok [/ping \$ipPing count=\$pingCount interface=\$iface]\
    \n    :if (\$pingsok <= 1) do={\
    \n        /interface ethernet disable \$iface\
    \n        /interface ethernet enable \$iface\
    \n    }\
    \n}\
    \n\
    \n"
/tool graphing interface
add
/tool graphing resource
add
/tool netwatch
add disabled=yes host=8.8.8.8 interval=30s
/tool sniffer
set filter-interface=eth7
