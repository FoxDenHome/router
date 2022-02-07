from network import NETWORK_CONFIG
from service import ServiceTemplate, SystemdService

class IptablesService(SystemdService):
    DIRECTION_IN = 1
    DIRECTION_OUT = 2

    def __init__(self):
        super().__init__("iptables", [
            ServiceTemplate("iptables", "/etc/iptables/rules.v4"),
            ServiceTemplate("ip6tables", "/etc/iptables/rules.v6"),
        ])

    def make_jumplist(self, chain, direction=DIRECTION_IN):
        jumps = []

        for name, network in NETWORK_CONFIG["interfaces"].items():
            if not network.get("exposed", False):
                continue

            jumps.append({
                "chain": f"NETWORK_{network['network']}",
                "match": f"-i {name}",
            })

        return "\n".join([
            f"-A {chain} {jump['match']} -j {jump['chain']}"
            for jump in jumps
        ] + [
            f":{c} - [0:0]"
            for c in set(map(lambda jump: jump['chain'], jumps))
        ])
