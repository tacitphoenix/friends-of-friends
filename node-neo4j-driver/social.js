const getNeo4jDriver = require("./yaml-config");

function runQuery(query, params, key) {
    const driver = getNeo4jDriver("../config.yml");
    const session = driver.session();

    session
        .run(query, params)
        .then(function (result) {
            session.close();
            result.records.forEach(function (record) {
                console.log(record.get(key));
                return record.get(key);
            });
            driver.close();
        })
        .catch(function (error) { 
            console.log(error);
        });
}

function insertFriends() {
    var insertQuery = 
    "UNWIND {pairs} as pair \
     MERGE (p1:Person {name:pair[0]}) \
     MERGE (p2:Person {name:pair[1]}) \
     MERGE (p1)-[:KNOWS]-(p2)";

    var data = [["Jim","Mike"],["Jim","Billy"],["Anna","Jim"],
            ["Anna","Mike"],["Sally","Anna"],["Joe","Sally"],
            ["Joe","Bob"],["Bob","Sally"]];

    runQuery(insertQuery, {pairs: data}, null);
}

function friendsOfAFriend() {
    const foafQuery = 
    "MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) \
    WHERE person.name = {name} \
    AND NOT (person)-[:KNOWS]-(foaf) \
    RETURN foaf.name AS name";

    runQuery(foafQuery, {name: "Joe"}, "name");
}

function commonFriends() {
    const commonFriendsQuery =
    "MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person) \
    WHERE user.name = {name1} AND foaf.name = {name2} \
    RETURN friend.name AS friend";

    runQuery(commonFriendsQuery, {name1: "Joe", name2: "Sally"}, "friend");
}

function connectingPaths() {
    const connectingPathsQuery =
    "MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person)) \
    WHERE p1.name = {name1} AND p2.name = {name2} \
    RETURN [n IN nodes(path) | n.name] as names";

    runQuery(connectingPathsQuery, {name1: "Joe", name2: "Billy"}, "names");
}

let a = insertFriends();
let b = friendsOfAFriend();
let c = commonFriends();
let d = connectingPaths();

console.log("insert", a);
console.log("friend", b);
console.log("common", c);
console.log("paths", d);
