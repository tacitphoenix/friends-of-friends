require './neo4j_init'

module Social
  class Graph
    def initialize
      @session = Neo4jInit.getSession("../config.yml")
    end

    def insert_friends
      insert_query = <<-QUERY
        UNWIND {pairs} as pair
        MERGE (p1:Person {name:pair[0]})
        MERGE (p2:Person {name:pair[1]})
        MERGE (p1)-[:KNOWS]-(p2)
      QUERY

      data = [['Jim', 'Mike'], ['Jim', 'Billy'], ['Anna', 'Jim'],
        ['Anna', 'Mike'], ['Sally', 'Anna'], ['Joe', 'Sally'],
        ['Joe', 'Bob'], ['Bob', 'Sally']]

      @session.query(insert_query, pairs: data)
    end

    def common_friends
      common_friends_query = <<-QUERY
        MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
        WHERE user.name = {user} AND foaf.name = {foaf}
        RETURN friend.name AS friend
      QUERY

      response = @session.query(common_friends_query, user: 'Joe', foaf: 'Sally')
      response.map(&:friend)
    end

    def friends_of_a_friend
      foaf_query = <<-QUERY
        MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf)
        WHERE person.name = {name}
        AND NOT (person)-[:KNOWS]-(foaf)
        RETURN foaf.name AS name
      QUERY

      response = @session.query(foaf_query, name: 'Joe')
      response.map(&:name)
    end

    def connecting_paths
      connecting_paths_query = <<-QUERY
        MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
        WHERE p1.name = {name1} AND p2.name = {name2}
        RETURN nodes(path) AS nodes
      QUERY

      response = @session.query(connecting_paths_query, name1: 'Joe', name2: 'Billy')
      response.first.nodes.map {|node| node.properties[:name] }
    end
  end
end