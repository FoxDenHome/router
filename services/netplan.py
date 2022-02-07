from ast import dump
from config import config_get_all, config_get_network_by_name
from service import Service, ServiceTemplate
from utils import dict_get_deep, write_if_different
from yaml import safe_dump as yaml_dump

class NetplanService(Service):
    def __init__(self):
        super().__init__("netplan", [], ["netplan", "apply"])

    def make_network_config(self, network):
        cfg = {
            "dhcp4": dict_get_deep(network, "addresses.v4.dhcp_client", False),
            "dhcp6": dict_get_deep(network, "addresses.v6.dhcp_client", False),
            "addresses": dict_get_deep(network, "addresses.v4.static", []) + dict_get_deep(network, "addresses.v6.static", []),
            "accept-ra": dict_get_deep(network, "addresses.v6.accept_ra", False),
            "mtu": dict_get_deep(network, "mtu", 1500),
        }
        return cfg

    def configure(self):
        config = config_get_all()

        netplan_network = {
            "ethernets": {},
            "bridges": {},
            "vlans": {},
            "openvswitch": {
                "ports": [],
            },
            "version": 2,
        }

        for interface in config["INTERFACES"]:
            networks = interface["networks"]
            
            needs_ovs = False
            forbid_ovs = False
            native_network = config_get_network_by_name(networks[0])
            iface_config = {}
            network_configs = []

            for network in networks:
                network_config = config_get_network_by_name(network)
                network_configs.append(network_config)
                if "vlan_id" in network_config:
                    needs_ovs = True
                else:
                    forbid_ovs = True
            if needs_ovs and forbid_ovs:
                raise  ValueError("Cannot mix VLAN and non-VLAN networks")
            
            if needs_ovs:
                if len(networks) > 1:
                    iface_config["openvswitch"] = {
                        "port_mode": "trunk",
                        "tag": native_network["vlan_id"],
                        "trunks": [network["vlan_id"] for network in network_configs if network != native_network],
                    }
                else:
                    iface_config["openvswitch"] = {
                        "port_mode": "access",
                        "tag": native_network["vlan_id"],
                    }
            else:
                iface_config = self.make_network_config(native_network)

            for iface in interface["interfaces"]:
                netplan_network["ethernets"][iface] = iface_config

        netplan_network["bridges"]["ovs0"] = {
        }
        for network in config["NETWORKS"]:
            if "vlan_id" not in network:
                continue
            id_name = f"vlan-{network['name'].lower()}"
            netplan_network["openvswitch"]["ports"].append(id_name)
            cfg = self.make_network_config(network)
            cfg["openvswitch"] = {
                "port_mode": "access",
                "tag": network["vlan_id"],
            }
            netplan_network["ethernets"][id_name] = cfg

        result = yaml_dump({
            "network": netplan_network,
        })

        return write_if_different("/etc/netplan/10-main.yaml", result)
