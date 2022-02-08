from service import SystemdService, ServiceTemplate

class DhcpdService(SystemdService):
    def __init__(self):
        super().__init__("isc-dhcp-server", [
            ServiceTemplate("dhcpd.conf", "/etc/dhcp/dhcpd.conf")
        ])
