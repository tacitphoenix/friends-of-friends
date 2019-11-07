[[{'userName', username}, {'password', password}, {'host', host}, _ , _, _]] = :yamerl_constr.file("../../config.yml")
{:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
conn = Bolt.Sips.conn()

# common friends
params = %{name1: "Joe", name2: "Billy"}
common_friends_query = """
  MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
  WHERE p1.name = {name1} AND p2.name = {name2}
  RETURN nodes(path) AS nodes
"""

Bolt.Sips.query!(conn, common_friends_query, params).results |> IO.inspect
