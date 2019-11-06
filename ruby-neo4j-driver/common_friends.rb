require './neo4j_init'

# Get session
session = Neo4jInit.getSession("../config.yml")

# Common friends
common_friends_query = <<QUERY
  MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
  WHERE user.name = {user} AND foaf.name = {foaf}
  RETURN friend.name AS friend
QUERY

response = session.query(common_friends_query, user: 'Joe', foaf: 'Sally')
puts response.map(&:friend)
puts '---------------------'