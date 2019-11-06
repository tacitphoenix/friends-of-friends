const getNeo4jDriver = require("./yaml-config");
const driver = getNeo4jDriver("./config.yml");
const session = driver.session();

const commonFriendsQuery =
"MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person) \
 WHERE user.name = {name1} AND foaf.name = {name2} \
 RETURN friend.name AS friend";

session
    .run(commonFriendsQuery, {name1: "Joe", name2: "Sally"})
    .then(function (result) {
        session.close();
        result.records.forEach(function (record) {
            console.log(record.get('friend'));
        });
        driver.close();
    })
    .catch(function (error) { 
        console.log(error);
    });
