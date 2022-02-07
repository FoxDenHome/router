from config import config_load_folder

def run():
    networks = config_load_folder("config/networks")
    
    interfaces = config_load_folder("config/interfaces")
    
    hosts = config_load_folder("config/hosts")
    
    rulesArray = config_load_folder("config/rules")
    rules = []
    for ruleVal in rulesArray:
        rules += ruleVal["rules"]
    print(rules)

    pass

if __name__ == "__main__":
    run()
