from neo4j import GraphDatabase, basic_auth
import neo4j_config

cfg = neo4j_config.neo4jConfig("../config.yml")
driver = GraphDatabase.driver("bolt://" + cfg['host'], auth=basic_auth(cfg['userName'], cfg['password']))
session = driver.session()

# Insert data
insert_query = '''
UNWIND {pairs} as pair
MERGE (p1:Person {name:pair[0]})
MERGE (p2:Person {name:pair[1]})
MERGE (p1)-[:KNOWS]-(p2);
'''

data = [["Jim","Mike"],["Jim","Billy"],["Anna","Jim"],
          ["Anna","Mike"],["Sally","Anna"],["Joe","Sally"],
          ["Joe","Bob"],["Bob","Sally"]]

session.run(insert_query, parameters={"pairs": data})

session.close()
