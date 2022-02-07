from network import NETWORK_CONFIG
from service import ServiceTemplate, SystemdService

class IptablesService(SystemdService):
    IN = 1
    OUT = 2

    def __init__(self):
        super().__init__("iptables", [
            ServiceTemplate("iptables", "/etc/iptables/rules.v4"),
            ServiceTemplate("ip6tables", "/etc/iptables/rules.v6"),
        ])

    def make_map_direction(self, direction, in_str, out_str):
        if direction == self.IN:
            return in_str
        elif direction == self.OUT:
            return out_str
        raise ValueError("Invalid direction")

    def make_jumplist(self, chain, direction):
        jumps = []

        for name, network in NETWORK_CONFIG["interfaces"].items():
            if not network.get("exposed", False):
                continue

            jumps.append({
                "chain": f"NETWORK_{network['network']}",
                "match": f"-{self.make_map_direction(direction, 'i', 'o')} {name}",
            })

        return "\n".join([
            f":{c} - [0:0]"
            for c in set(map(lambda jump: jump['chain'], jumps))
        ] + [
            f"-A {chain} {jump['match']} -j {jump['chain']}"
            for jump in jumps
        ])
