[[{'username', username}, {'password', password}, {'host', host}, _ , _]] = :yamerl_constr.file("../../config.yml")
{:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
conn = Bolt.Sips.conn()

# common friends
{name1, name2} = {"Joe", "Billy"}
common_friends_query = """
  MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
  WHERE p1.name = \"#{name1}\" AND p2.name = \"#{name2}\"
  RETURN nodes(path) AS nodes
"""

Bolt.Sips.query!(conn, common_friends_query).results |> IO.inspect
