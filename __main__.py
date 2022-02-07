#!/usr/bin/env python3

from services.dhcpd import DhcpdService
from services.netplan import NetplanService

def run():
    services = [
        DhcpdService(),
        NetplanService(),
    ]

    is_valid = True
    for service in services:
        if not service.validate():
            print(f"Service {service.name} configuration is not valid")
            is_valid = False

    if not is_valid:
        exit(1)

    for service in services:
        service.configure()

    print("All done!")

if __name__ == "__main__":
    run()
