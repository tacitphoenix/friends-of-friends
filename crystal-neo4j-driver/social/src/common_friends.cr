require "yaml"
require "neo4j"

config = YAML.parse(File.read("../../config.yml"))
connStr = "bolt://#{config["userName"]}:#{config["password"]}@#{config["host"]}:#{config["boltPort"]}"
conn = Neo4j::Bolt::Connection.new(connStr, ssl: false)

query = <<-CYPHER
MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
WHERE user.name = $user AND foaf.name = $foaf
RETURN friend.name AS friend
CYPHER

params = {"user" => "Joe", "foaf" => "Sally"}
result = conn.execute(query, params)

pp result.data