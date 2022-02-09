from math import perm
from config import config_get_host_by_name
from network import NETWORK_CONFIG
from service import ServiceTemplate, SystemdService
from utils import dict_get_deep, address_is_ipv4, address_is_ipv6

class IptablesService(SystemdService):
    IN = 1
    OUT = 2

    IPV4ONLY = 1
    IPV6ONLY = 2

    def __init__(self):
        super().__init__("iptables", [
            ServiceTemplate("iptables", "/etc/iptables/rules.v4"),
            ServiceTemplate("ip6tables", "/etc/iptables/rules.v6"),
        ])

    def resolve_host(self, name):
        host = config_get_host_by_name(name)
        addr_ipv4 = dict_get_deep(host, "addresses.ipv4")
        addr_ipv6 = dict_get_deep(host, "addresses.ipv6")

        if addr_ipv4 and addr_ipv6:
            return [addr_ipv4, addr_ipv6]
        elif addr_ipv4:
            return [addr_ipv4]
        elif addr_ipv6:
            return [addr_ipv6]
        else:
            raise ValueError(f"Host {name} has no addresses")

    def make_map_networks(self, networks, prefix):
        network_map = NETWORK_CONFIG["network_map"]

        rule = []
        for net in networks:
            local_prefix = prefix
            if net[0] == "!":
                net = net[1:]
                local_prefix = f"! {prefix}"
            for iface in network_map[net]:
                rule.append(f"{local_prefix} {iface}")
        return rule

    def make_map_direct(self, targets, prefix, rule=None):
        if rule is None:
            rule = []
        for target in targets:
            target = str(target)
            if target[0] == "!":
                rule.append(f"! {prefix} {target[1:]}")
            else:
                rule.append(f"{prefix} {target}")
        return rule

    def permutate_all(self, chain, offset=0):
        if offset >= len(chain):
            return [""]

        next_offset = offset + 1
        ch = chain[offset]
        if ch is None:
            return []

        if len(ch) < 1:
            return self.permutate_all(chain, next_offset)

        result = []

        for c in ch:
            for subc in self.permutate_all(chain, next_offset):
                result.append(f"{c} {subc}".strip())

        return result

    def make_rules(self, rule, action, chain, address_filter):
        if address_filter == self.IPV4ONLY:
            address_filter = address_is_ipv4
        elif address_filter == self.IPV6ONLY:
            address_filter = address_is_ipv6
        return self.make_rules_int(rule, action, chain, address_filter)

    def make_rules_host_net_address(self, rule, prefix, iface_matcher, address_matcher, address_filter):
        permutation_chain = []
    
        permutation_chain.append(
            self.make_map_networks(dict_get_deep(rule, f"{prefix}.networks", []), iface_matcher)
        )

        addresses_no = False
        hosts_no = False

        addrs = dict_get_deep(rule, f"{prefix}.addresses", [])
        filtered_addrs = [addr for addr in addrs if address_filter(addr)]
        if len(addrs) >= 1 and len(filtered_addrs) < 1:
            addresses_no = True
        permutation_chain.append(
            self.make_map_direct(filtered_addrs, address_matcher)
        )

        res_addresses = self.permutate_all(permutation_chain)
        permutation_chain = []

        res_hosts = []
        hosts = dict_get_deep(rule, f"{prefix}.hosts", [])
        for host in hosts:
            permutation_chain = []
            addrs = self.resolve_host(host)
            filtered_addrs = [addr for addr in addrs if address_filter(addr)]
            if len(filtered_addrs) < 1:
                continue
            permutation_chain.append(
                self.make_map_networks([host["network"]], iface_matcher)
            )
            permutation_chain.append(
                self.make_map_direct(filtered_addrs, address_matcher)
            )
            res_hosts += self.permutate_all(permutation_chain)

        hosts_no = len(hosts) > 0 and len(res_hosts) < 1

        if (addresses_no and len(res_hosts) < 1) or (hosts_no and len(res_addresses) < 1):
            return None

        return res_addresses + res_hosts

    def make_rules_int(self, rule, action, chain, address_filter):
        if not action:
            return ""

        permutation_chain = []
 
        permutation_chain.append(
            self.make_map_direct(dict_get_deep(rule, "protocols", []), "-p")
        )

        if not dict_get_deep(rule, "from.all", False):
            res = self.make_rules_host_net_address(rule, "from", "-i", "-s", address_filter)
            if res is None:
                return ""
            permutation_chain.append(res)

            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "from.ports", []), "--sport")
            )

        if not dict_get_deep(rule, "to.all", False):
            res = self.make_rules_host_net_address(rule, "to", "-o", "-d", address_filter)
            if res is None:
                return ""
            permutation_chain.append(res)

            permutation_chain.append(
                self.make_map_direct(dict_get_deep(rule, "to.ports", []), "--dport")
            )

        return "\n".join(
            [f"-A {chain} {rule.strip()} -j {action}" for rule in self.permutate_all(permutation_chain)]
        )
