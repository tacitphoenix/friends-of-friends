defmodule Social do
    def insert_friends do
        pairs = [
            ["Jim", "Mike"], ["Jim", "Billy"], ["Anna", "Jim"],
            ["Anna", "Mike"], ["Sally", "Anna"], ["Joe", "Sally"],
            ["Joe", "Bob"], ["Bob", "Sally"]
        ]

        insert_query = """
            UNWIND {pairs} as pair
            MERGE (p1:Person {name:pair[0]})
            MERGE (p2:Person {name:pair[1]})
            MERGE (p1)-[:KNOWS]-(p2)
        """

        Bolt.Sips.query!(conn(), insert_query, %{pairs: pairs})
    end

    def common_friends do
        params = %{user: "Joe", foaf: "Sally"}
        common_friends_query = """
            MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
            WHERE user.name = {user} AND foaf.name = {foaf}
            RETURN friend.name AS friend
        """

        Bolt.Sips.query!(conn(), common_friends_query, params)
    end

    def friends_of_a_friend do
        params = %{foaf: "Joe"}
        common_friends_query = """
            MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf)
            WHERE person.name = {foaf}
            AND NOT (person)-[:KNOWS]-(foaf)
            RETURN foaf.name AS name
        """

        Bolt.Sips.query!(conn(), common_friends_query, params)
    end

    def connecting_paths do
        params = %{name1: "Joe", name2: "Billy"}
        common_friends_query = """
            MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
            WHERE p1.name = {name1} AND p2.name = {name2}
            RETURN nodes(path) AS nodes
        """

        Bolt.Sips.query!(conn(), common_friends_query, params)
    end

    defp conn do
        [[{'userName', username}, {'password', password}, {'host', host}, _ , _, _]] = :yamerl_constr.file("../../config.yml")
        {:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
        Bolt.Sips.conn()
    end
end