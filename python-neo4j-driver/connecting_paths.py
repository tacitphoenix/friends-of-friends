from neo4j import GraphDatabase, basic_auth
import neo4j_config

cfg = neo4j_config.neo4jConfig("../config.yml")
driver = GraphDatabase.driver("bolt://" + cfg['host'], auth=basic_auth(cfg['userName'], cfg['password']))
session = driver.session()

# Connecting paths

connecting_paths_query = """
MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
WHERE p1.name = {name1} AND p2.name = {name2}
RETURN path
"""

results = session.run(connecting_paths_query, parameters={"name1": "Joe", "name2": "Billy"})
for record in results:
    print (record["path"])

session.close()
