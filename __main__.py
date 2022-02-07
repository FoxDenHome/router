#!/usr/bin/env python3

from argparse import ArgumentParser

from services.dhcpd import DhcpdService
from services.netplan import NetplanService
from utils import set_file_target_prefix

def run():
    parser = ArgumentParser()
    parser.add_argument('--prefix', dest='prefix', default='')
    args = parser.parse_args()
    set_file_target_prefix(args.prefix)

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
