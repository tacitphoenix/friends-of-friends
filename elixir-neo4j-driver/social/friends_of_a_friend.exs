[[{'username', username}, {'password', password}, {'host', host}, _ , _]] = :yamerl_constr.file("../../config.yml")
{:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
conn = Bolt.Sips.conn()

# common friends
foaf = "Joe"
common_friends_query = """
  MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf)
  WHERE person.name = \"#{foaf}\"
  AND NOT (person)-[:KNOWS]-(foaf)
  RETURN foaf.name AS name
"""

Bolt.Sips.query!(conn, common_friends_query) |> IO.inspect
