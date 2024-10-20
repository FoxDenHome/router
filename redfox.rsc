# ____-__-__ __:__:__ by RouterOS 7.16.1
# software id = REMOVED
#
/disk set slot1 media-interface=none media-sharing=no slot=slot1
/disk set slot2 media-interface=none media-sharing=no slot=slot2
/disk set slot3 media-interface=none media-sharing=no slot=slot3
/disk set slot4 media-interface=none media-sharing=no slot=slot4
/disk set slot5 media-interface=none media-sharing=no slot=slot5
/disk set slot6 media-interface=none media-sharing=no slot=slot6
/disk set slot7 media-interface=none media-sharing=no slot=slot7
/disk set slot8 media-interface=none media-sharing=no slot=slot8
/disk set slot9 media-interface=none media-sharing=no slot=slot9
/disk set slot10 media-interface=none media-sharing=no slot=slot10
/disk set slot11 media-interface=none media-sharing=no slot=slot11
/disk set slot12 media-interface=none media-sharing=no slot=slot12
/disk set slot13 media-interface=none media-sharing=no slot=slot13
/disk add media-interface=none media-sharing=no slot=tmpfs-scratch tmpfs-max-size=16000000 type=tmpfs
/interface ethernet set [ find default-name=ether1 ] disable-running-check=no name=eth0
/interface 6to4 add comment=router !keepalive local-address=144.202.81.146 name=6to4-router remote-qaddress=REMOVED
/interface 6to4 add comment=router-backup !keepalive local-address=144.202.81.146 name=6to4-router-backup remote-qaddress=REMOVED
/interface wireguard add listen-port=13232 mtu=1420 name=wg-s2s
/iot lora servers add address=eu.mikrotik.thethings.industries name=TTN-EU protocol=UDP
/iot lora servers add address=us.mikrotik.thethings.industries name=TTN-US protocol=UDP
/iot lora servers add address=eu1.cloud.thethings.industries name="TTS Cloud (eu1)" protocol=UDP
/iot lora servers add address=nam1.cloud.thethings.industries name="TTS Cloud (nam1)" protocol=UDP
/iot lora servers add address=au1.cloud.thethings.industries name="TTS Cloud (au1)" protocol=UDP
/iot lora servers add address=eu1.cloud.thethings.network name="TTN V3 (eu1)" protocol=UDP
/iot lora servers add address=nam1.cloud.thethings.network name="TTN V3 (nam1)" protocol=UDP
/iot lora servers add address=au1.cloud.thethings.network name="TTN V3 (au1)" protocol=UDP
/routing bgp template set default disabled=yes routing-table=main
/ip firewall connection tracking set loose-tcp-tracking=no
/ip settings set tcp-syncookies=yes
/ipv6 settings set accept-redirects=no accept-router-advertisements=no
/interface wireguard peers add allowed-address=10.0.0.0/8,10.99.1.1/32 interface=wg-s2s is-responder=yes name=router persistent-keepalive=25s public-key="nCTAIMDv50QhwjCw72FwP2u2pKGMcqxJ09DQ9wJdxH0="
/interface wireguard peers add allowed-address=10.99.1.2/32 interface=wg-s2s is-responder=yes name=router-backup persistent-keepalive=25s public-key="8zUl7b1frvuzcBrIA5lNsegzzyAOniaZ4tczSdoqcWM="
/interface wireguard peers add allowed-address=10.99.10.2/32 endpoint-address=23.239.97.10 endpoint-port=13232 interface=wg-s2s name=icefox persistent-keepalive=25s public-key="t4vx8Lz7TNazvwid9I3jtbowkfb8oNM4TpdttEIUjRs="
/ip address add address=144.202.81.146/23 interface=eth0 network=144.202.80.0
/ip address add address=10.99.10.1/16 interface=wg-s2s network=10.99.0.0
/ip dhcp-client add disabled=yes interface=eth0
/ip dns set servers=8.8.8.8,8.8.4.4
/ip firewall filter add action=fasttrack-connection chain=forward comment="established, related" connection-state=established,related hw-offload=yes
/ip firewall filter add action=accept chain=forward comment="established, related" connection-state=established,related
/ip firewall filter add action=fasttrack-connection chain=input comment="established, related" connection-state=established,related hw-offload=yes
/ip firewall filter add action=accept chain=input comment="established, related" connection-state=established,related
/ip firewall filter add action=accept chain=input comment=loopback in-interface=lo
/ip firewall filter add action=accept chain=input comment=ICMP protocol=icmp
/ip firewall filter add action=accept chain=input comment=WireGuard dst-port=13232 protocol=udp src-port=""
/ip firewall filter add action=accept chain=input comment=6to4 protocol=ipv6-encap
/ip firewall filter add action=accept chain=input in-interface=wg-s2s
/ip firewall filter add action=drop chain=input
/ip firewall filter add action=drop chain=forward log=yes
/ip ipsec profile set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip route add gateway=144.202.80.1
/ip route add blackhole disabled=no dst-address=192.168.0.0/16 gateway="" routing-table=main suppress-hw-offload=no
/ipv6 route add disabled=no distance=1 dst-address=::/0 gateway=fe80::fc00:4ff:feb1:d2e3%eth0 routing-table=main suppress-hw-offload=no
/ipv6 route add blackhole disabled=no distance=100 dst-address=2a0e:7d44:f000::/48 gateway="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ipv6 route add blackhole disabled=no distance=50 dst-address=2a0e:7d44:f00b::/48 routing-table=main suppress-hw-offload=no
/ipv6 route add blackhole disabled=no distance=100 dst-address=2a0e:7d44:f00a::/48 gateway="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ipv6 route add blackhole disabled=no distance=100 dst-address=2a0e:7d44:f069::/48 gateway="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www disabled=yes
/ip service set ssh address=10.0.0.0/8
/ip service set api disabled=yes
/ip service set winbox address=10.0.0.0/8
/ip service set api-ssl disabled=yes
/ip ssh set forwarding-enabled=both host-key-type=ed25519 strong-crypto=yes
/ipv6 address add address=2001:19f0:8001:f07:5400:4ff:feb1:d2e3 advertise=no interface=eth0
/ipv6 address add address=2a0e:7d44:f000::1/48 advertise=no interface=eth0
/ipv6 address add address=2a0e:7d44:f000:a::1 advertise=no interface=6to4-router
/ipv6 address add address=2a0e:7d44:f000:b::1 advertise=no interface=6to4-router-backup
/ipv6 firewall address-list add address=2a0e:7d44:f000::/48 list=bgp6-vultr-direct
/ipv6 firewall address-list add address=2a0e:7d44:f069::/48 list=bgp6-router
/ipv6 firewall address-list add address=2a0e:7d44:f00a::/48 list=bgp6-router
/ipv6 firewall address-list add address=2a0e:7d44:f069::/48 list=bgp6-router-backup
/ipv6 firewall address-list add address=2a0e:7d44:f00b::/48 list=bgp6-router-backup
/ipv6 firewall address-list add address=2a0e:7d44:f069::/48 list=bgp6-vultr-direct
/ipv6 firewall address-list add address=2a0e:7d44:f00a::/48 list=bgp6-vultr-direct
/ipv6 firewall address-list add address=2a0e:7d44:f00b::/48 list=bgp6-vultr-direct
/ipv6 firewall filter add action=accept chain=input comment="related, established" connection-state=established,related
/ipv6 firewall filter add action=accept chain=input comment=loopback in-interface=lo
/ipv6 firewall filter add action=accept chain=input comment=ICMPv6 protocol=icmpv6
/ipv6 firewall filter add action=accept chain=input comment=WireGuard dst-port=13232 protocol=udp
/ipv6 firewall filter add action=drop chain=input
/ipv6 firewall filter add action=accept chain=forward
/ipv6 firewall raw add action=notrack chain=prerouting dst-address=2a0e:7d44:f000::/40
/ipv6 firewall raw add action=notrack chain=prerouting src-address=2a0e:7d44:f000::/40
/ipv6 firewall raw add action=accept chain=output disabled=yes log=yes
/ipv6 nd set [ find default=yes ] disabled=yes
/routing bgp connection add address-families=ip as=207618 connect=yes disabled=no input.filter=reject-all listen=yes local.address=144.202.81.146 .role=ebgp multihop=yes name=bgp-vultr-v4 nexthop-choice=force-self output.default-originate=never .remove-private-as=yes remote.address=169.254.169.254/32 .as=64515 router-id=144.202.81.146 routing-table=main
/routing bgp connection add address-families=ipv6 as=207618 connect=yes disabled=no input.filter=reject-all listen=yes local.address=2001:19f0:8001:f07:5400:4ff:feb1:d2e3 .role=ebgp multihop=yes name=bgp-vultr-v6 nexthop-choice=force-self output.default-originate=never .network=bgp6-vultr-direct .remove-private-as=yes remote.address=2001:19f0:ffff::1/128 .as=64515 router-id=144.202.81.146 routing-table=main
/routing bgp connection add address-families=ipv6 as=207618 connect=yes disabled=no input.filter=router-in listen=yes local.address=10.99.10.1 .role=ebgp multihop=yes name=bgp-router output.default-originate=never .filter-chain=reject-all remote.address=10.99.1.1/32 .as=64601 router-id=144.202.81.146 routing-table=main
/routing bgp connection add address-families=ipv6 as=207618 connect=yes disabled=no input.filter=route-backup-in listen=yes local.address=10.99.10.1 .role=ebgp multihop=yes name=bgp-router-backup output.default-originate=never .filter-chain=reject-all remote.address=10.99.1.2/32 .as=64602 router-id=144.202.81.146 routing-table=main
/routing filter rule add chain=router-in disabled=no rule="if (dst in bgp6-router) { set gw 2a0e:7d44:f000:a::2; set distance 50; accept; }"
/routing filter rule add chain=route-backup-in disabled=no rule="if (dst in bgp6-router-backup) { set gw 2a0e:7d44:f000:b::2; set distance 60; accept; }"
/routing filter rule add chain=reject-all disabled=no rule="reject;"
/system clock set time-zone-name=America/Los_Angeles
/system identity set name=redfox
/system note set show-at-login=no
/system scheduler add interval=15s name=ip-update on-event="/system/script/run ip-update\r\
    \n" policy=read,write,policy,test,sensitive start-date=2024-07-02 start-time=17:25:00
/system script add dont-require-permissions=yes name=ip-update owner=admin policy=read,write,policy,test,sensitive source=":local IPRouter [ /interface/wireguard/peers/get [ find name=\"router\" ] current-endpoint-address ]\r\
    \n:local IPRouterBackup [ /interface/wireguard/peers/get [ find name=\"router-backup\" ] current-endpoint-address ]\r\
    \n\r\
    \n:if ( \$IPRouterBackup != \"\" ) do={\r\
    \n    /interface/6to4/set [ find comment=\"router-backup\" remote-address!=\"\$IPRouterBackup\" ] remote-address=\"\$IPRouterBackup\"\r\
    \n    :put \"Set router-backup to \$IPRouterBackup\"\r\
    \n}\r\
    \n\r\
    \n:if ( \$IPRouter != \"\" ) do={\r\
    \n    /interface/6to4/set [ find comment=\"router\" remote-address!=\"\$IPRouter\" ] remote-address=\"\$IPRouter\"\r\
    \n    :put \"Set router to \$IPRouter\"\r\
    \n}\r\
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
/tool sniffer set filter-mac-protocol=ipv6
