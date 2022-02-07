from config import config_get_host_by_name, config_load_all
from network import NETWORK_CONFIG
from service import ServiceTemplate, SystemdService
from utils import dict_get_deep

class IptablesService(SystemdService):
    IN = 1
    OUT = 2

    V4ONLY = 1
    V6ONLY = 2

    def __init__(self):
        super().__init__("iptables", [
            ServiceTemplate("iptables", "/etc/iptables/rules.v4"),
            ServiceTemplate("ip6tables", "/etc/iptables/rules.v6"),
        ])

    def resolve_host(self, name):
        host = config_get_host_by_name(name)
        addr_v4 = dict_get_deep(host, "addresses.v4")
        addr_v6 = dict_get_deep(host, "addresses.v6")

        if addr_v4 and addr_v6:
            return [addr_v4, addr_v6]
        elif addr_v4:
            return [addr_v4]
        elif addr_v6:
            return [addr_v6]
        else:
            raise ValueError(f"Host {name} has no addresses")

    def make_map_networks(self, networks, prefix):
        network_map = NETWORK_CONFIG["network_map"]

        rule = []
        for net in networks:
            for iface in network_map[net]:
                rule.append(f"{prefix} {iface}")
        return rule

    def make_map_direct(self, addresses, prefix):
        rule = []
        for addr in addresses:
            rule.append(f"{prefix} {addr}")
        return rule

    def permutate_all(self, chain, offset=0):
        if offset >= len(chain):
            return [""]

        next_offset = offset + 1
        if len(chain[offset]) < 1:
            return self.permutate_all(chain, next_offset)

        result = []

        for c in chain[offset]:
            for subc in self.permutate_all(chain, next_offset):
                result.append(f"{c} {subc}")

        return result

    def make_rules(self, rule, action, chain, address_filter):
        return self.make_rules_int(rule, action, chain, address_filter)

    def make_rules_int(self, rule, action, chain, address_filter):
        if not action:
            return ""

        permutation_chain = []
 
        permutation_chain.append(
            self.make_map_direct(dict_get_deep(rule, "protocols", []), "-p")
        )

        if not dict_get_deep(rule, "from.all", False):
            permutation_chain.append(
                self.make_map_networks(dict_get_deep(rule, "from.networks", []), "-i")
            )

            addrs = dict_get_deep(rule, "from.addresses", [])
            for host in dict_get_deep(rule, "from.hosts", []):
                addrs += self.resolve_host(host)
            filtered_addrs = [addr for addr in addrs if address_filter(addr)]
            if len(addrs) >= 1 and len(filtered_addrs) < 1:
                return ""
            permutation_chain.append(
                self.make_map_direct(filtered_addrs, "-s")
            )

            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "from.ports", []), "--sport")
            )

        if not dict_get_deep(rule, "to.all", False):
            permutation_chain.append(
                self.make_map_networks(dict_get_deep(rule, "to.networks", []), "-o")
            )

            addrs = dict_get_deep(rule, "to.addresses", [])
            for host in dict_get_deep(rule, "to.hosts", []):
                addrs += self.resolve_host(host)
            filtered_addrs = [addr for addr in addrs if address_filter(addr)]
            if len(addrs) >= 1 and len(filtered_addrs) < 1:
                return ""
            permutation_chain.append(
                self.make_map_direct(filtered_addrs, "-d")
            )

            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "to.ports", []), "--dport")
            )

        return "\n".join(
            [f"-A {chain} {rule.strip()} -j {action}" for rule in self.permutate_all(permutation_chain)]
        )
