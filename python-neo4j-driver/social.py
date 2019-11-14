from neo4j import GraphDatabase, basic_auth
import yaml

def runQuery(query, params, key):
    configFile = "../config.yml"
    with open(configFile, "r") as ymlfile:
        cfg = yaml.safe_load(ymlfile)

    driver = GraphDatabase.driver("bolt://" + cfg['host'], auth=basic_auth(cfg['userName'], cfg['password']))
    session = driver.session()
    result = session.run(query, parameters=params)
    results = getResults(result, key)
    session.close()
    driver.close()  
    return results

def getResults(result, key):
    for record in result:
        return record[key]

def insert_friends():
    insert_query = '''
    UNWIND {pairs} as pair
    MERGE (p1:Person {name:pair[0]})
    MERGE (p2:Person {name:pair[1]})
    MERGE (p1)-[:KNOWS]-(p2);
    '''
    data = [["Jim","Mike"],["Jim","Billy"],["Anna","Jim"],
          ["Anna","Mike"],["Sally","Anna"],["Joe","Sally"],
          ["Joe","Bob"],["Bob","Sally"]]
    params = {"pairs": data}
    return runQuery(insert_query, params, "")

def common_friends():
    common_friends_query = """
    MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
    WHERE user.name = {user} AND foaf.name = {foaf}
    RETURN friend.name AS friend
    """
    params = {"user": "Joe", "foaf": "Sally"}
    return runQuery(common_friends_query, params, "friend")

def friends_of_a_friend():
    foaf_query = '''
    MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) 
    WHERE person.name = {name}
    AND NOT (person)-[:KNOWS]-(foaf)
    RETURN foaf.name AS name
    '''
    params = {"name": "Joe"}
    return runQuery(foaf_query, params, "name")

def connecting_paths():
    connecting_paths_query = """
    MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
    WHERE p1.name = {name1} AND p2.name = {name2}
    RETURN path
    """
    params = {"name1": "Joe", "name2": "Billy"}
    return runQuery(connecting_paths_query, params, "path")
