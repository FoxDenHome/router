# jan/14/2023 22:39:22 by RouterOS 7.7
# software id = REMOVED
#
# model = CRS305-1G-4S+
# serial number = REMOVED
/interface bridge
add admin-mac=18:FD:74:7B:0C:B9 auto-mac=no name=bridge priority=0xA000 \
    vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] advertise=100M-full,1000M-full l2mtu=9092 \
    mtu=9000 name=eth1-switch-dori-office
set [ find default-name=sfp-sfpplus1 ] advertise=1000M-full,10000M-full \
    l2mtu=9092 mtu=9000 name=sfp1-capefox speed=10Gbps
set [ find default-name=sfp-sfpplus2 ] advertise=1000M-full,10000M-full \
    l2mtu=9092 mtu=9000 name=sfp2 speed=10Gbps
set [ find default-name=sfp-sfpplus3 ] advertise=1000M-full,10000M-full \
    l2mtu=9092 mtu=9000 name=sfp3 speed=10Gbps
set [ find default-name=sfp-sfpplus4 ] advertise=1000M-full,10000M-full \
    l2mtu=9092 mtu=9000 name=sfp4-switch-rack-agg speed=10Gbps
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
/routing id
add disabled=no id=10.1.10.8 name=main-id select-dynamic-id=""
/snmp community
set [ find default=yes ] disabled=yes
add addresses=::/0 name=monitor_REMOVED
/interface bridge port
add bridge=bridge ingress-filtering=no interface=eth1-switch-dori-office \
    multicast-router=disabled
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=sfp1-capefox multicast-router=disabled pvid=2
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=sfp2 multicast-router=disabled pvid=2
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=sfp3 multicast-router=disabled pvid=2
add bridge=bridge ingress-filtering=no interface=sfp4-switch-rack-agg \
    multicast-router=disabled
/ip neighbor discovery-settings
set protocol=lldp
/ip settings
set ip-forward=no max-neighbor-entries=8192 tcp-syncookies=yes
/ipv6 settings
set forward=no
/interface bridge vlan
add bridge=bridge untagged=\
    bridge,sfp4-switch-rack-agg,eth1-switch-dori-office vlan-ids=1
add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,eth1-switch-dori-office \
    vlan-ids=2
add bridge=bridge tagged=sfp4-switch-rack-agg,bridge,eth1-switch-dori-office \
    vlan-ids=3
add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,eth1-switch-dori-office \
    vlan-ids=4
add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,eth1-switch-dori-office \
    vlan-ids=5
add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,eth1-switch-dori-office \
    vlan-ids=6
/interface ovpn-server server
set auth=sha1,md5
/ip address
add address=10.1.10.8/16 interface=bridge network=10.1.0.0
/ip dns
set servers=10.1.0.53
/ip route
add gateway=10.1.0.1
/snmp
set contact=mikrotik@foxden.network enabled=yes location="Dori Office" \
    trap-generators=""
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=switch-dori-office-10g
/system leds settings
set all-leds-off=after-1min
/system ntp client
set enabled=yes
/system ntp client servers
add address=10.1.0.123
/system routerboard settings
set boot-os=router-os silent-boot=yes
/tool sniffer
set filter-interface=eth1-switch-dori-office filter-mac-protocol=lldp
