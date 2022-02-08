from service import ServiceTemplate, SystemdService

class KeepalivedService(SystemdService):
    def __init__(self):
        super().__init__("keepalived", [
            ServiceTemplate("keepalived.conf", "/etc/keepalived/keepalived.conf")
        ])
