from config import config_get_all, config_get_network_by_name
from utils import dict_get_deep

class NetworkConfigbuilder():
    def __init__(self):
        pass

    def get_mtu(self, network):
        return dict_get_deep(network, "mtu", 1500)

    def make_network_config(self, network):
        cfg = {
            "addresses": dict_get_deep(network, "addresses.v4.static", []) + dict_get_deep(network, "addresses.v6.static", []),
            "network": network["name"],
            "cfg": network,
        }
        return cfg

    def build(self):
        config = config_get_all()

        network_interfaces_computed = {}

        bridge_port_arrays = {}
        network_groups_computed = {}

        network_map = {}

        for network in config["NETWORKS"]:
            network_map[network["name"]] = []

            if "group" not in network:
                continue

            group = network["group"]

            bridge_id_name = f"br-{group.lower()}"

            if group not in network_groups_computed:
                network_groups_computed[group] = {
                    "vlans": [],
                }

            network_groups_computed[group]["vlans"].append(network["vlan_id"])
            
            if bridge_id_name not in network_interfaces_computed:
                cfg = {}
                cfg["ports"] = []
                network_interfaces_computed[bridge_id_name] = cfg
            else:
                cfg = network_interfaces_computed[bridge_id_name]

            if network.get("is_pvid", False):
                ports = cfg["ports"]
                cfg = self.make_network_config(network)
                cfg["vlan_aware"] = True
                cfg["ports"] = ports
                bridge_port_arrays[group] = cfg["ports"]
                cfg["pvid"] = network["vlan_id"]
                cfg["vlans"] = network_groups_computed[group]["vlans"]
                cfg["type"] = "bridge"
                network_interfaces_computed[bridge_id_name] = cfg
                network_map[network["name"]].append(bridge_id_name)
            else:
                vlan_id_name = f"vlan-{network['name']}"
                cfg = self.make_network_config(network)
                cfg["pvid"] = network["vlan_id"]
                cfg["type"] = "vlan"
                cfg["vlans"] = [cfg["pvid"]]
                network_interfaces_computed[vlan_id_name] = cfg
                network_map[network["name"]].append(vlan_id_name)

        for interface in config["INTERFACES"]:
            networks = interface["networks"]

            native_network = config_get_network_by_name(networks[0])
            if len(networks) == 1:
                if "group" in native_network:
                    cfg = {
                        "type": "access",
                        "mtu": self.get_mtu(native_network),
                        "pvid": native_network["vlan_id"],
                        "vlans": [native_network["vlan_id"]],
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
                    "pvid": native_network["vlan_id"],
                    "vlans": [config_get_network_by_name(network)["vlan_id"] for network in networks],
                }

            for iface in interface["interfaces"]:
                if "bridge" in cfg:
                    ports = bridge_port_arrays[cfg["bridge"]]
                    if iface not in ports:
                        ports.append(iface)
                else:
                    for network in networks:
                        network_map[network].append(iface)
                network_interfaces_computed[iface] = cfg

        return {
            "interfaces": network_interfaces_computed,
            "network_map": network_map,
        }

NETWORK_CONFIG = NetworkConfigbuilder().build()
