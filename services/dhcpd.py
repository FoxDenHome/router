from service import SystemdService, ServiceTemplate

class DhcpdService(SystemdService):
    def __init__(self):
        super().__init__("dhcpd", [
            ServiceTemplate("dhcpd.conf", "/etc/dhcpd/dhcpd.conf")
        ])
