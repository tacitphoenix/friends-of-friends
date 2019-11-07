require "yaml"
require "neo4j"

config = YAML.parse(File.read("../../config.yml"))
connStr = "bolt://#{config["userName"]}:#{config["password"]}@#{config["host"]}:#{config["boltPort"]}"
connection = Neo4j::Bolt::Connection.new(connStr, ssl: false)

data = [['Jim', 'Mike'], ['Jim', 'Billy'], ['Anna', 'Jim'],
        ['Anna', 'Mike'], ['Sally', 'Anna'], ['Joe', 'Sally'],
        ['Joe', 'Bob'], ['Bob', 'Sally']]

result = connection.execute <<-CYPHER, { "user" => "Joe", "foaf" => "Sally" }
UNWIND {pairs} as pair
  MERGE (p1:Person {name:pair[0]})
  MERGE (p2:Person {name:pair[1]})
  MERGE (p1)-[:KNOWS]-(p2)
CYPHER

pp result.data