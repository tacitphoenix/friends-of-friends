const getNeo4jDriver = require("./yaml-config");
const driver = getNeo4jDriver("../config.yml");
const session = driver.session();

var insertQuery = 
  "UNWIND {pairs} as pair \
   MERGE (p1:Person {name:pair[0]}) \
   MERGE (p2:Person {name:pair[1]}) \
   MERGE (p1)-[:KNOWS]-(p2)";

var data = [["Jim","Mike"],["Jim","Billy"],["Anna","Jim"],
            ["Anna","Mike"],["Sally","Anna"],["Joe","Sally"],
            ["Joe","Bob"],["Bob","Sally"]];

session
    .run(insertQuery, {pairs: data})
    .then(function (result) {
        session.close();
        result.records.forEach(function (record) {
            console.log(record);
        });
        driver.close();
    })
    .catch(function (error) { 
        console.log(error);
    });
