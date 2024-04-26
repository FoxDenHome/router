/container
add interface=veth-snirouter logging=yes mounts=snirouter-config start-on-boot=yes remote-image="foxdenhome/sni-vhost-proxy/sni-vhost-proxy:compressed"
add interface=veth-foxdns logging=yes mounts=foxdns-config start-on-boot=yes remote-image="doridian/foxdns/foxdns:nossl-compressed"
add interface=veth-foxdns-internal logging=yes mounts=foxdns-internal-config start-on-boot=yes remote-image="doridian/foxdns/foxdns:ssl-compressed"
