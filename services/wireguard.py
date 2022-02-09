from service import ServiceTemplate, SystemdService
from network import NETWORK_CONFIG

def wireguard_matcher(dir, file):
    return not file.startswith("custom-")

class WireguardService(SystemdService):
    def __init__(self):
        super().__init__("wg-quick", [])

    def configure(self):
        self.collect_current_files("/etc/wireguard")

        for ifname, iface in NETWORK_CONFIG["interfaces"].items():
            if iface["phytype"] != "wireguard":
                continue

            if iface["type"] != "standalone":
                raise Exception("Wireguard only supports standalone interfaces")

            data = {
                "ifname": ifname,
                "iface": iface,
            }
            tpl = ServiceTemplate("wireguard.conf", f"/etc/wireguard/{ifname}.conf")
            if self.render_template(tpl, custom=data):
                self.needs_restart = True

        self.remove_extra_files()
