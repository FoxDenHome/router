from service import ServiceTemplate, SystemdService
from network import NETWORK_CONFIG

class NetworkdService(SystemdService):
    def __init__(self):
        super().__init__("systemd-networkd", [])

    def configure(self):
        custom = self.custom_template_data()

        templates = []
        for ifname, iface in NETWORK_CONFIG["interfaces"].items():
            data = {
                "ifname": ifname,
                "iface": iface,
            }
            if iface["type"] in ["vlan", "bridge"]:
                tpl = ServiceTemplate("systemd.netdev", f"/etc/systemd/network/99-{ifname}.netdev")
                if tpl.render(custom=data, caller=self):
                    self.needs_restart = True
            tpl = ServiceTemplate("systemd.network", f"/etc/systemd/network/99-{ifname}.network")
            if tpl.render(custom=data, caller=self):
                self.needs_restart = True
