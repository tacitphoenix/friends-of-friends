require "yaml"
require "neo4j"

module Social
  VERSION = "0.1.0"

  class Graph
    def initialize
      config = YAML.parse(File.read("../../config.yml"))
      connStr = "bolt://#{config["userName"]}:#{config["password"]}@#{config["host"]}:#{config["boltPort"]}"
      @conn = Neo4j::Bolt::Connection.new(connStr, ssl: false)
    end

    def insert_friends
      data = [["Jim", "Mike"], ["Jim", "Billy"], ["Anna", "Jim"],
        ["Anna", "Mike"], ["Sally", "Anna"], ["Joe", "Sally"],
        ["Joe", "Bob"], ["Bob", "Sally"]]
      query = <<-CYPHER
        UNWIND $pairs as pair
        MERGE (p1:Person {name:pair[0]})
        MERGE (p2:Person {name:pair[1]})
        MERGE (p1)-[:KNOWS]-(p2)
      CYPHER

      params = {"pairs" => data}
      @conn.execute(query, params)
    end

    def common_friends
      query = <<-CYPHER
        MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
        WHERE user.name = $user AND foaf.name = $foaf
        RETURN friend.name AS friend
      CYPHER

      params = {"user" => "Joe", "foaf" => "Sally"}
      @conn.execute(query, params)
    end

    def connecting_paths
      query = <<-CYPHER
        MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
        WHERE p1.name = {name1} AND p2.name = {name2}
        RETURN nodes(path) AS nodes
      CYPHER

      params = {"name1" => "Joe", "name2" => "Billy"}
      @conn.execute(query, params)
    end

    def friends_of_a_friend
      query = <<-CYPHER
        MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf)
        WHERE person.name = $name
        AND NOT (person)-[:KNOWS]-(foaf)
        RETURN foaf.name AS name
      CYPHER

      params = {"name" => "Joe"}
      @conn.execute(query, params)
    end
  end
end
