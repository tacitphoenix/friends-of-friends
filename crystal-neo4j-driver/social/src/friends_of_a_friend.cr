require "yaml"
require "neo4j"

config = YAML.parse(File.read("../../config.yml"))
connStr = "bolt://#{config["userName"]}:#{config["password"]}@#{config["host"]}:#{config["boltPort"]}"
conn = Neo4j::Bolt::Connection.new(connStr, ssl: false)

query = <<-CYPHER
MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf)
  WHERE person.name = $name
    AND NOT (person)-[:KNOWS]-(foaf)
  RETURN foaf.name AS name
CYPHER

params = {"name" => "Joe"}
result = conn.execute(query, params)

pp result.data