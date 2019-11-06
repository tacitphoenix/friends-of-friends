require './neo4j_init'

# Get session
session = Neo4jInit.getSession("../config.yml")

# Friends of a friend
foaf_query = <<QUERY
  MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf)
  WHERE person.name = {name}
    AND NOT (person)-[:KNOWS]-(foaf)
  RETURN foaf.name AS name
QUERY

response = session.query(foaf_query, name: 'Joe')
puts response.map(&:name)
puts '---------------------'