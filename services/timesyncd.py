from service import ServiceTemplate, SystemdService

class TimesyncdService(SystemdService):
    def __init__(self):
        super().__init__("systemd-timesyncd", [
            ServiceTemplate("timesyncd.conf", "/etc/systemd/timesyncd.conf")
        ])
