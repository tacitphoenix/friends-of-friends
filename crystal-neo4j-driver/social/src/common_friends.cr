require "yaml"
require "neo4j"

config = YAML.parse(File.read("../../config.yml"))
connStr = "bolt://#{config["userName"]}:#{config["password"]}@#{config["host"]}:#{config["boltPort"]}"
connection = Neo4j::Bolt::Connection.new(connStr, ssl: false)

result = connection.execute <<-CYPHER, { "user" => "Joe", "foaf" => "Sally" }
MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
WHERE user.name = $user AND foaf.name = $foaf
RETURN friend.name AS friend
CYPHER

pp result.data