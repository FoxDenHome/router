#!/usr/bin/env python3

from service import ServiceTemplate, SystemdService

def run():
    services = []
    services.append(SystemdService("dhcpd", [
        ServiceTemplate("dhcpd.conf", "/etc/dhcpd/dhcpd.conf")
    ]))

    is_valid = True
    for service in services:
        if not service.validate():
            print(f"Service {service.name} configurationm is not valid")
            is_valid = False

    if not is_valid:
        return

    for service in services:
        service.configure()

if __name__ == "__main__":
    run()
