// create people
create
(joe:Person{name: "Joe", age: 43}),
(bob:Person{name: "Bob", age: 50}),
(sal:Person{name: "Sally", age: 38}),
(ann:Person{name: "Anna", age: 24}),
(mike:Person{name: "Mike", age: 28}),
(jim:Person{name: "Jim", age: 34}),
(bill:Person{name: "Billy", age: 21})

// create sports and hobbies
create
(bb:Sport{name: "Basketball"}),
(fb:Sport{name: "Football"}),
(sc:Sport{name: "Soccer"}),
(ch:Sport:Hobby{name: "Chess"})

// create sport and hobby relationships
create
(joe)-[:PLAYS]->(fb),
(joe)-[:PLAYS]->(bb),
(sal)-[:PLAYS]->(sc),
(bob)-[:PLAYS]->(ch),
(ann)-[:PLAYS]->(bb),
(ann)-[:PLAYS]->(fb),
(mike)-[:PLAYS]->(fb),
(mike)-[:PLAYS]->(sc),
(jim)-[:PLAYS]->(bb),
(bill)-[:PLAYS]->(bb),
(bill)-[:PLAYS]->(fb),
(bill)-[:PLAYS]->(sc),
(bill)-[:PLAYS]->(ch)

// create people relationships
create
(joe)-[:KNOWS{since: 2014}]->(sal),
(joe)-[:KNOWS{since: 2005}]->(bob),
(bob)-[:KNOWS{since: 2016}]->(sal),
(sal)-[:KNOWS{since: 2010}]->(ann),
(ann)-[:KNOWS{since: 1996}]->(mike),
(ann)-[:KNOWS{since: 2018}]->(jim),
(mike)-[:KNOWS{since: 2015}]->(jim),
(jim)-[:KNOWS{since: 2017}]->(bill);
