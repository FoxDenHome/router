from jinja2 import Environment, FileSystemLoader, select_autoescape
from config import config_get_all
from utils import cidr_to_ip, cidr_to_subnet_mask, build_classless_routes_bytes, dict_get_deep, write_if_different
from network import NETWORK_CONFIG
from secrets import get_secret

TEMPLATES_DIR = "./templates"

env = Environment(
    loader=FileSystemLoader(TEMPLATES_DIR),
    autoescape=select_autoescape([])
)
env.filters["cidr_to_subnet_mask"] = cidr_to_subnet_mask
env.filters["cidr_to_ip"] = cidr_to_ip
env.filters["build_classless_routes_bytes"] = build_classless_routes_bytes
env.filters["dict_get_deep"] = dict_get_deep
env.filters["secret"] = get_secret

def render_template(template, target, caller, custom=None):
    tpl = env.get_template(template)
    data = tpl.render(config_get_all(), NETWORK_CONFIG=NETWORK_CONFIG, caller=caller, custom=custom)

    return write_if_different(target, data)
