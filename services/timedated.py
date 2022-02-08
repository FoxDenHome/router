from service import ServiceTemplate, SystemdService

class TimedatedService(SystemdService):
    def __init__(self):
        super().__init__("systemd-timedated", [
            ServiceTemplate("timedated.conf", "/etc/systemd/timedated.conf")
        ])
