const getNeo4jDriver = require("./yaml-config");
const driver = getNeo4jDriver("../config.yml");
const session = driver.session();

const connectingPathsQuery =
"MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person)) \
 WHERE p1.name = {name1} AND p2.name = {name2} \
 RETURN [n IN nodes(path) | n.name] as names";

session
    .run(connectingPathsQuery, {name1: "Joe", name2: "Sally"})
    .then(function (result) {
        session.close();
        result.records.forEach(function (record) {
            console.log(record.get('names'));
        });
        driver.close();
    })
    .catch(function (error) { 
        console.log(error);
    });
