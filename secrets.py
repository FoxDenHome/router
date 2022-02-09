from yaml import safe_load as yaml_load

_SECRETS = None
def load_secrets():
    global _SECRETS
    if _SECRETS:
        return _SECRETS
    fh = open("config/secrets.yml", "r")
    _SECRETS = yaml_load(fh)
    fh.close()
    return _SECRETS

def get_secret(name):
    return load_secrets()[name]
