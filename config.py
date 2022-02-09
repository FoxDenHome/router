from yaml import safe_load as yaml_load
from os.path import dirname, join, isfile, isdir, relpath
from os import listdir
from jinja2 import Environment, FileSystemLoader, select_autoescape
from mergedeep import merge, Strategy
from secrets import get_secret

CONFIG_DIR = "./config"

_all_config = None

env = Environment(
    loader=FileSystemLoader(CONFIG_DIR),
    autoescape=select_autoescape(["yaml"])
)
env.filters["secret"] = get_secret

def config_load(file, parent={}):
    file = relpath(file, CONFIG_DIR)
    tpl = env.get_template(file.replace("\\", "/")) # Jinja2 does not like backslashes
    config = yaml_load(tpl.render(parent))

    if "parent" in config:
        add = config_load(join(CONFIG_DIR, join(dirname(file), config["parent"])), config)
        config.update(add)

    return config

def config_load_folder(folder, config=None):
    if config is None:
        config = []
    for f in sorted(listdir(folder)):
        if f[0] == "." or f == "templates":
            continue
        f = join(folder, f)
        if isfile(f):
            config.append(config_load(f))
        elif isdir(f):
            config_load_folder(f, config)
    return config    

def config_merge(list):
    result = {}
    merge(result, *list, strategy=Strategy.TYPESAFE_ADDITIVE)
    return result

def config_load_all():
    networks = config_load_folder("config/networks")
    interfaces = config_load_folder("config/interfaces")
    hosts = config_load_folder("config/hosts")
    system = config_merge(config_load_folder("config/system"))

    rulesArray = config_load_folder("config/rules")
    rules = []
    for ruleVal in rulesArray:
        rules += ruleVal["rules"]

    return {
        "NETWORKS": networks,
        "INTERFACES": interfaces,
        "HOSTS": hosts,
        "RULES": rules,
        "SYSTEM": system,
    }

def config_get_all():
    global _all_config
    if _all_config is not None:
        return _all_config
    _all_config = config_load_all()
    return _all_config

def config_get_network_by_name(name):
    for network in config_get_all()["NETWORKS"]:
        if network["name"] == name:
            return network
    raise ValueError(f"Network {name} not found")

def config_get_host_by_name(name):
    for host in config_get_all()["HOSTS"]:
        if host["name"] == name:
            return host
    raise ValueError(f"Host {name} not found")
