defmodule Knows do
  def create(conn, pairs) do
    insert_query = """
    UNWIND {pairs} as pair
    MERGE (p1:Person {name:pair[0]})
    MERGE (p2:Person {name:pair[1]})
    MERGE (p1)-[:KNOWS]-(p2)
    """

    Bolt.Sips.query!(conn, insert_query, %{pairs: pairs}).results |> IO.inspect
  end
end

[[{'userName', username}, {'password', password}, {'host', host}, _ , _, _]] = :yamerl_constr.file("../../config.yml")
{:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
conn = Bolt.Sips.conn()

pairs = [["Jim", "Mike"], ["Jim", "Billy"], ["Anna", "Jim"],
        ["Anna", "Mike"], ["Sally", "Anna"], ["Joe", "Sally"],
        ["Joe", "Bob"], ["Bob", "Sally"]]

Knows.create(conn, pairs)
