[[{'userName', username}, {'password', password}, {'host', host}, _ , _, _]] = :yamerl_constr.file("../../config.yml")
{:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
conn = Bolt.Sips.conn()

# common friends
params = %{user: "Joe", foaf: "Sally"}
common_friends_query = """
  MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
  WHERE user.name = {user} AND foaf.name = {foaf}
  RETURN friend.name AS friend
"""

Bolt.Sips.query!(conn, common_friends_query, params) |> IO.inspect
