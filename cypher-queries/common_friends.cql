match (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person) 
where user.name = "Joe" and foaf.name = "Sally"
return friend.name as friend;