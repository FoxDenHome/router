#!/usr/bin/env python3

from service import ServiceTemplate, SystemdService

def run():
    dhcp_service = SystemdService("dhcpd", [
        ServiceTemplate("dhcpd.conf", "/etc/dhcpd/dhcpd.conf")
    ])
    print(dhcp_service.configure())

if __name__ == "__main__":
    run()
