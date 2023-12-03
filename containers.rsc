/container
add interface=veth-foxdns logging=yes mounts=foxdns-config start-on-boot=yes remote-image="foxdenhome/foxdns/foxdns:compressed"
add interface=veth-snirouter logging=yes mounts=snirouter-config start-on-boot=yes remote-image="foxdenhome/sni-vhost-proxy/sni-vhost-proxy:compressed"
