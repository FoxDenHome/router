from yaml import safe_load as yaml_load
from os.path import dirname, join, isfile, isdir, relpath, abspath
from os import listdir
from jinja2 import Environment, FileSystemLoader, select_autoescape

CONFIG_DIR = "./config"

env = Environment(
    loader=FileSystemLoader(CONFIG_DIR),
    autoescape=select_autoescape(["yaml"])
)

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
    for f in listdir(folder):
        if f[0] == "." or f == "templates":
            continue
        f = join(folder, f)
        if isfile(f):
            config.append(config_load(f))
        elif isdir(f):
            config_load_folder(f, config)
    return config    
