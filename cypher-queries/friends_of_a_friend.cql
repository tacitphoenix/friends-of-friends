match (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) 
where person.name = "Joe"
and not (person)-[:KNOWS]-(foaf)
return foaf.name as name;