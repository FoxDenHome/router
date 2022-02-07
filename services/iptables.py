from network import NETWORK_CONFIG
from service import ServiceTemplate, SystemdService
from utils import dict_get_deep

class IptablesService(SystemdService):
    IN = 1
    OUT = 2

    def __init__(self):
        super().__init__("iptables", [
            ServiceTemplate("iptables", "/etc/iptables/rules.v4"),
            ServiceTemplate("ip6tables", "/etc/iptables/rules.v6"),
        ])

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

    def make_rules(self, rule, action, chain):
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
            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "from.addresses", []), "-s")
            )
            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "from.ports", []), "--sport")
            )

        if not dict_get_deep(rule, "to.all", False):
            permutation_chain.append(
                self.make_map_networks(dict_get_deep(rule, "to.networks", []), "-o")
            )
            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "to.addresses", []), "-d")
            )
            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "to.ports", []), "--dport")
            )

        return "\n".join(
            [f"-A {chain} {rule.strip()} -j {action}" for rule in self.permutate_all(permutation_chain)]
        )
