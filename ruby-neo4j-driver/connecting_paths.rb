require './neo4j_init'

# Get session
session = Neo4jInit.getSession("../config.yml")

# Connecting paths
connecting_paths_query = <<QUERY
  MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
  WHERE p1.name = {name1} AND p2.name = {name2}
  RETURN nodes(path) AS nodes
QUERY

response = session.query(connecting_paths_query, name1: 'Joe', name2: 'Billy')
puts response.first.nodes.map {|node| node.properties[:name] }
puts '---------------------'