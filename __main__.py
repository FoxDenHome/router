#!/usr/bin/env python3

from argparse import ArgumentParser
from utils import set_file_target_prefix
from os import chdir
from os.path import dirname

from services.dhcpd import DhcpdService
from services.networkd import NetworkdService
from services.iptables import IptablesService
from services.resolved import ResolvedService
from services.timesyncd import TimesyncdService

def run():
    chdir(dirname(__file__))

    parser = ArgumentParser()
    parser.add_argument('--prefix', dest='prefix', default='')
    parser.add_argument('--no-restart', dest='no_restart', action='store_true')
    parser.add_argument('--dry-run', dest='dry_run', action='store_true')
    args = parser.parse_args()

    if args.dry_run:
        args.prefix = "./tmp"
        args.no_restart = True

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

    if not args.no_restart:
        for service in services:
            service.restart_if_needed()

    print("All done!")

if __name__ == "__main__":
    run()
