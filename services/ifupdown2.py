from config import config_get_all, config_get_network_by_name
from service import ServiceTemplate, SystemdService
from utils import dict_get_deep

class IfUpDown2Service(SystemdService):
    def __init__(self):
        super().__init__("networking", [
            ServiceTemplate("interfaces", "/etc/network/interfaces"),
        ])
