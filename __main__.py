#!/usr/bin/env python3

from argparse import ArgumentParser
from utils import set_file_target_prefix

from services.dhcpd import DhcpdService
from services.networkd import NetworkdService
from services.iptables import IptablesService
from services.resolved import ResolvedService
from services.timesyncd import TimesyncdService

def run():
    parser = ArgumentParser()
    parser.add_argument('--prefix', dest='prefix', default='')
    args = parser.parse_args()
    set_file_target_prefix(args.prefix)

    services = [
        DhcpdService(),
        NetworkdService(),
        IptablesService(),
        ResolvedService(),
        TimesyncdService(),
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

    #for service in services:
    #    service.restart_if_needed()

    print("All done!")

if __name__ == "__main__":
    run()
