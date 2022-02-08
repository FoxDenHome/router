from network import NETWORK_CONFIG
from service import ServiceTemplate, SystemdService

class KeepalivedService(SystemdService):
    MASTER_IFACE_TYPES = set(["vlan", "bridge", "standalone"])

    def __init__(self):
        super().__init__("keepalived", [
            ServiceTemplate("keepalived.conf", "/etc/keepalived/keepalived.conf")
        ])

    def get_iface(self, network):
        ifaces_vlan = NETWORK_CONFIG["network_map"][network]
        ifaces_map = NETWORK_CONFIG["interfaces"]

        for iface in ifaces_vlan:
            iface_obj = ifaces_map[iface]
            if iface_obj["type"] in self.MASTER_IFACE_TYPES:
                return iface
