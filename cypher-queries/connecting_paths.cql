match path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
where p1.name = "Joe" and p2.name = "Billy"
return path;