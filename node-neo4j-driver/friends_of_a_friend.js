const getNeo4jDriver = require("./yaml-config");
const driver = getNeo4jDriver("../config.yml");
const session = driver.session();

const foafQuery = 
 "MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) \
  WHERE person.name = {name} \
   AND NOT (person)-[:KNOWS]-(foaf) \
  RETURN foaf.name AS name";

session
    .run(foafQuery, {name: "Joe"})
    .then(function (result) {
        session.close();
        result.records.forEach(function (record) {
            console.log(record.get('name'));
        });
        driver.close();
    })
    .catch(function (error) { 
        console.log(error);
    });
