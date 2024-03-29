# ---/--/---- --:--:-- by RouterOS 7.8
# software id = REMOVED
#
# model = CRS305-1G-4S+
# serial number = REMOVED
/interface bridge add admin-mac=18:FD:74:7B:0C:B9 auto-mac=no name=bridge priority=0xA000 vlan-filtering=yes
/interface ethernet set [ find default-name=ether1 ] advertise=100M-full,1000M-full l2mtu=9092 mtu=9000 name=eth1-ups-dori-office rx-flow-control=on tx-flow-control=on
/interface ethernet set [ find default-name=sfp-sfpplus1 ] advertise=1000M-full,10000M-full l2mtu=9092 mtu=9000 name=sfp1-capefox rx-flow-control=on speed=10Gbps tx-flow-control=on
/interface ethernet set [ find default-name=sfp-sfpplus2 ] advertise=100M-full,1000M-full,10000M-full,2500M-full,5000M-full l2mtu=9092 mtu=9000 name=sfp2 rx-flow-control=on speed=10Gbps tx-flow-control=on
/interface ethernet set [ find default-name=sfp-sfpplus3 ] advertise=100M-full,1000M-full,10000M-full,2500M-full,5000M-full l2mtu=9092 mtu=9000 name=sfp3-switch-dori-tv rx-flow-control=on speed=10Gbps tx-flow-control=on
/interface ethernet set [ find default-name=sfp-sfpplus4 ] advertise=1000M-full,10000M-full l2mtu=9092 mtu=9000 name=sfp4-switch-rack-agg rx-flow-control=on speed=10Gbps tx-flow-control=on
/disk add slot=tmpfs-scratch tmpfs-max-size=16000000 type=tmpfs
/interface lte apn set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=REMOVED
/ip pool add name=pool-oob ranges=192.168.88.100-192.168.88.200
/port set 0 name=serial0
/routing id add disabled=no id=10.1.10.8 name=main-id select-dynamic-id=""
/snmp community set [ find default=yes ] disabled=yes
/snmp community add addresses=::/0 name=monitor_REMOVED
/interface bridge port add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged interface=sfp1-capefox multicast-router=disabled pvid=2
/interface bridge port add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged interface=sfp2 multicast-router=disabled pvid=2
/interface bridge port add bridge=bridge ingress-filtering=no interface=sfp3-switch-dori-tv multicast-router=disabled
/interface bridge port add bridge=bridge ingress-filtering=no interface=sfp4-switch-rack-agg multicast-router=disabled
/interface bridge port add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged interface=eth1-ups-dori-office
/ip neighbor discovery-settings set protocol=lldp
/ip settings set ip-forward=no max-neighbor-entries=8192 tcp-syncookies=yes
/ipv6 settings set forward=no
/interface bridge vlan add bridge=bridge untagged=bridge,sfp4-switch-rack-agg,sfp3-switch-dori-tv vlan-ids=1
/interface bridge vlan add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,sfp3-switch-dori-tv vlan-ids=2
/interface bridge vlan add bridge=bridge tagged=sfp4-switch-rack-agg,bridge,sfp3-switch-dori-tv vlan-ids=3
/interface bridge vlan add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,sfp3-switch-dori-tv vlan-ids=4
/interface bridge vlan add bridge=bridge tagged=bridge,sfp4-switch-rack-agg,sfp3-switch-dori-tv vlan-ids=5
/interface bridge vlan add bridge=bridge tagged=bridge,sfp3-switch-dori-tv,sfp4-switch-rack-agg vlan-ids=6
/interface ovpn-server server set auth=sha1,md5
/ip address add address=10.1.10.8/16 interface=bridge network=10.1.0.0
/ip dhcp-server config set store-leases-disk=never
/ip dns set servers=10.1.0.53
/ip route add gateway=10.1.0.1
/snmp set contact=mikrotik@foxden.network enabled=yes location="Dori Office" trap-generators=""
/system clock set time-zone-autodetect=no time-zone-name=America/Los_Angeles
/system identity set name=switch-dori-office-10g
/system leds settings set all-leds-off=after-1min
/system ntp client set enabled=yes
/system ntp client servers add address=10.1.0.123
/system routerboard settings set boot-os=router-os silent-boot=yes
/tool sniffer set filter-interface=eth1-ups-dori-office filter-mac-protocol=lldp
