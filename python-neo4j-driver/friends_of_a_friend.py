from neo4j import GraphDatabase, basic_auth
import neo4j_config

cfg = neo4j_config.neo4jConfig("../config.yml")
driver = GraphDatabase.driver("bolt://" + cfg['host'], auth=basic_auth(cfg['userName'], cfg['password']))
session = driver.session()

# Friends of a friend

foaf_query = '''
MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) 
WHERE person.name = {name}
  AND NOT (person)-[:KNOWS]-(foaf)
RETURN foaf.name AS name
'''

results = session.run(foaf_query, parameters={"name": "Joe"})
for record in results:
    print(record["name"])

session.close()
