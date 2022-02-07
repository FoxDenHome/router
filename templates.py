from os import makedirs
from os.path import dirname
from jinja2 import Environment, FileSystemLoader, select_autoescape
from config import config_get_all
from utils import cidr_to_ip, cidr_to_subnet_mask, build_classless_routes_bytes

TEMPLATES_DIR = "./templates"
TEMPLATE_TARGET_PREFIX = "./tmp"

env = Environment(
    loader=FileSystemLoader(TEMPLATES_DIR),
    autoescape=select_autoescape([])
)
env.filters["cidr_to_subnet_mask"] = cidr_to_subnet_mask
env.filters["cidr_to_ip"] = cidr_to_ip
env.filters["build_classless_routes_bytes"] = build_classless_routes_bytes

def render_template(template, target):
    target = TEMPLATE_TARGET_PREFIX + target # We do not use path.join on purpose here!
    makedirs(dirname(target), exist_ok=True)

    tpl = env.get_template(template)
    data = tpl.render(config_get_all()).encode("utf8")

    try:
        with open(target, "rb") as fh:
            oldData = fh.read()
            fh.close()
            if oldData == data:
                return False
    except FileNotFoundError:
        pass

    with open(target, "wb") as fh:
        fh.write(data)
        fh.close()
    return True
