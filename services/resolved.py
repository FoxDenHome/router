from service import ServiceTemplate, SystemdService

class ResolvedService(SystemdService):
    def __init__(self):
        super().__init__("systemd-resolved", [
            ServiceTemplate("resolved.conf", "/etc/systemd/resolved.conf")
        ])
