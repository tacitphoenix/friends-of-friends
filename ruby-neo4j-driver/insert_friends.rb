require './neo4j_init'

# Get session
session = Neo4jInit.getSession("./config.yml")

# Insert data
insert_query = <<QUERY
  UNWIND {pairs} as pair
  MERGE (p1:Person {name:pair[0]})
  MERGE (p2:Person {name:pair[1]})
  MERGE (p1)-[:KNOWS]-(p2)
QUERY

data = [['Jim', 'Mike'], ['Jim', 'Billy'], ['Anna', 'Jim'],
        ['Anna', 'Mike'], ['Sally', 'Anna'], ['Joe', 'Sally'],
        ['Joe', 'Bob'], ['Bob', 'Sally']]

session.query(insert_query, pairs: data)
