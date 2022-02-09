from service import ServiceTemplate, SystemdService
from network import NETWORK_CONFIG

class WireguardService(SystemdService):
    def __init__(self):
        super().__init__("wg-quick", [])

    def configure(self):
        for ifname, iface in NETWORK_CONFIG["interfaces"].items():
            if iface["phytype"] != "wireguard":
                continue

            if iface["type"] != "standalone":
                raise Exception("Wireguard only supports standalone interfaces")

            data = {
                "ifname": ifname,
                "iface": iface,
            }
            tpl = ServiceTemplate("wireguard.conf", f"/etc/wg-quick/{ifname}.conf")
            if tpl.render(custom=data, caller=self):
                self.needs_restart = True
