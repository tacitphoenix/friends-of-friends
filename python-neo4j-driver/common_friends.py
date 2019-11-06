from neo4j import GraphDatabase, basic_auth
import neo4j_config

cfg = neo4j_config.neo4jConfig("../config.yml")
driver = GraphDatabase.driver("bolt://" + cfg['host'], auth=basic_auth(cfg['userName'], cfg['password']))
session = driver.session()

# Common friends

common_friends_query = """
MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
WHERE user.name = {user} AND foaf.name = {foaf}
RETURN friend.name AS friend
"""

results = session.run(common_friends_query, parameters={"user": "Joe", "foaf": "Sally"})
for record in results:
    print(record["friend"])

session.close()
