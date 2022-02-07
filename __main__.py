#!/usr/bin/env python3

from templates import render_template

def run():
    print(render_template("dhcpd.conf", "/etc/dhcpd/dhcpd.conf"))

if __name__ == "__main__":
    run()
