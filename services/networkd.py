from service import ServiceTemplate, SystemdService
from network import NETWORK_CONFIG

def networkd_matcher(dir, file):
    return file.startswith("10-auto-")

class NetworkdService(SystemdService):
    def __init__(self):
        super().__init__("systemd-networkd", [])

    def configure(self):
        self.collect_current_files("/etc/systemd/network", networkd_matcher)

        for ifname, iface in NETWORK_CONFIG["interfaces"].items():
            if iface["phytype"] != "ethernet":
                continue

            data = {
                "ifname": ifname,
                "iface": iface,
            }
            if iface["type"] in ["vlan", "bridge"]:
                tpl = ServiceTemplate("systemd.netdev", f"/etc/systemd/network/10-auto-{ifname}.netdev")
                if self.render_template(tpl, custom=data):
                    self.needs_restart = True
            tpl = ServiceTemplate("systemd.network", f"/etc/systemd/network/10-auto-{ifname}.network")
            if self.render_template(tpl, custom=data):
                self.needs_restart = True

        self.remove_extra_files()
