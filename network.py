from config import config_get_all, config_get_network_by_name
from utils import dict_get_deep

class NetworkConfigbuilder():
    def __init__(self):
        pass

    def get_mtu(self, network):
        return dict_get_deep(network, "mtu", 1500)

    def make_network_config(self, network):
        cfg = {
            "dhcp4": dict_get_deep(network, "addresses.v4.dhcp_client", False),
            "dhcp6": dict_get_deep(network, "addresses.v6.dhcp_client", False),
            "addresses": dict_get_deep(network, "addresses.v4.static", []) + dict_get_deep(network, "addresses.v6.static", []),
            "accept_ra": dict_get_deep(network, "addresses.v6.accept_ra", False),
            "mtu": self.get_mtu(network),
            "network": network["name"],
            "exposed": True,
        }
        return cfg

    def build(self):
        config = config_get_all()

        NETWORK_CONFIG_GLOBAL = {}

        NETWORK_BRIDGE_PORT_ARRAYS = {}
        NETWORK_GROUPS = {}

        for network in config["NETWORKS"]:
            if "group" not in network:
                continue

            group = network["group"]

            bridge_id_name = f"br-{group.lower()}"

            if group not in NETWORK_GROUPS:
                NETWORK_GROUPS[group] = {
                    "vlans": [],
                }

            NETWORK_GROUPS[group]["vlans"].append(network["vlan_id"])
            
            if bridge_id_name not in NETWORK_CONFIG_GLOBAL:
                cfg = {}
                cfg["ports"] = []
                NETWORK_CONFIG_GLOBAL[bridge_id_name] = cfg
            else:
                cfg = NETWORK_CONFIG_GLOBAL[bridge_id_name]

            if network.get("is_pvid", False):
                ports = cfg["ports"]
                cfg = self.make_network_config(network)
                cfg["vlan_aware"] = True
                cfg["ports"] = ports
                NETWORK_BRIDGE_PORT_ARRAYS[group] = cfg["ports"]
                cfg["pvid"] = network["vlan_id"]
                cfg["vlans"] = NETWORK_GROUPS[group]["vlans"]
                cfg["type"] = "bridge"
                NETWORK_CONFIG_GLOBAL[bridge_id_name] = cfg
            else:
                vlan_id_name = f"br-{group.lower()}.{network['vlan_id']}"
                cfg = self.make_network_config(network)
                cfg["pvid"] = network["vlan_id"]
                cfg["type"] = "vlan"
                NETWORK_CONFIG_GLOBAL[vlan_id_name] = cfg

        for interface in config["INTERFACES"]:
            networks = interface["networks"]

            native_network = config_get_network_by_name(networks[0])
            if len(networks) == 1:
                if "group" in native_network:
                    cfg = {
                        "type": "access",
                        "mtu": self.get_mtu(native_network),
                        "pvid": native_network["vlan_id"],
                        "bridge": native_network["group"],
                    }
                else:
                    cfg = self.make_network_config(native_network)
                    cfg["type"] = "standalone"
            else:
                cfg = {
                    "type": "trunk",
                    "mtu": self.get_mtu(native_network),
                    "bridge": native_network["group"],
                    "vlans": [config_get_network_by_name(network)["vlan_id"] for network in networks],
                }

            for iface in interface["interfaces"]:
                if "bridge" in cfg:
                    ports = NETWORK_BRIDGE_PORT_ARRAYS[cfg["bridge"]]
                    if iface not in ports:
                        ports.append(iface)
                NETWORK_CONFIG_GLOBAL[iface] = cfg

        return {
            "interfaces": NETWORK_CONFIG_GLOBAL,
        }

NETWORK_CONFIG = NetworkConfigbuilder().build()