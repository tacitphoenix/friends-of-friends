defmodule Knows do
  def create(conn, {name1, name2}) do
    insert_query = """
    MERGE (p1:Person {name:\"#{name1}\"})
    MERGE (p2:Person {name:\"#{name2}\"})
    MERGE (p1)-[:KNOWS]-(p2)
    """

    Bolt.Sips.query!(conn, insert_query).results |> IO.inspect
  end
end

[[{'username', username}, {'password', password}, {'host', host}, _ , _]] = :yamerl_constr.file("../../config.yml")
{:ok, _neo} = Bolt.Sips.start_link(url: "bolt://#{username}:#{password}@#{host}")
conn = Bolt.Sips.conn()

pairs = [{'Jim', 'Mike'}, {'Jim', 'Billy'}, {'Anna', 'Jim'},
        {'Anna', 'Mike'}, {'Sally', 'Anna'}, {'Joe', 'Sally'},
        {'Joe', 'Bob'}, {'Bob', 'Sally'}]

Enum.each(pairs, &(Knows.create(conn, &1)))
