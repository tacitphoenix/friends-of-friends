require "yaml"
require "neo4j"

config = YAML.parse(File.read("../../config.yml"))
connStr = "bolt://#{config["userName"]}:#{config["password"]}@#{config["host"]}:#{config["boltPort"]}"
conn = Neo4j::Bolt::Connection.new(connStr, ssl: false)

query = <<-CYPHER
MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
  WHERE p1.name = $name1 AND p2.name = $name2
  RETURN nodes(path) AS nodes
CYPHER

params = {"name1" => "Joe", "name2" => "Billy"}
result = conn.execute(query, params)

pp result.data