import yaml

def neo4jConfig(configFile):
    with open(configFile, "r") as ymlfile:
        cfg = yaml.safe_load(ymlfile)
    return cfg
