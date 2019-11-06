import yaml

def neo4jConfig(configFile):
    with open(configFile, "r") as ymlfile:
        cfg = yaml.load(ymlfile)
    return cfg
