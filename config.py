from yaml import safe_load as yaml_load
from os.path import dirname, join, isfile, isdir
from os import listdir
from jinja2 import Environment, FileSystemLoader, select_autoescape
env = Environment(
    loader=FileSystemLoader("config"),
    autoescape=select_autoescape(["yaml"])
)

def config_load(file, parent={}):
    fh = open(file, "r")
    data = fh.read()
    fh.close()
    tpl = env.from_string(data)
    config = yaml_load(tpl.render(parent))

    if "parent" in config:
        add = config_load(join(dirname(file), config["parent"]), config)
        config.update(add)

    return config

def config_load_folder(folder, config=None):
    if config is None:
        config = []
    for f in listdir(folder):
        if f[0] == "." or f == "templates":
            continue
        f = join(folder, f)
        if isfile(f):
            config.append(config_load(f))
        elif isdir(f):
            config_load_folder(f, config)
    return config    
