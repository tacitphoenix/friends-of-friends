package com.tacitphoenix.neo4j;

import org.neo4j.driver.v1.*;

import static org.neo4j.driver.v1.Values.parameters;

import java.util.List;
import static java.util.Arrays.asList;
import static java.util.Collections.singletonMap;

public class Social {
        private Session session;

        public StatementResult insertFriends() {
        List data =
                asList(asList("Jim","Mike"),asList("Jim","Billy"),asList("Anna","Jim"),
                asList("Anna","Mike"),asList("Sally","Anna"),asList("Joe","Sally"),
                asList("Joe","Bob"),asList("Bob","Sally"));

        String insertQuery = 
                "UNWIND {pairs} as pair " +
                "MERGE (p1:Person {name:pair[0]}) " +
                "MERGE (p2:Person {name:pair[1]}) " +
                "MERGE (p1)-[:KNOWS]-(p2)";

        return session.run(insertQuery,singletonMap("pairs",data));
    }

    public StatementResult friendsOfAFriend(){
        String foafQuery =
                "MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) "+
                "WHERE person.name = {name} " +
                "AND NOT (person)-[:KNOWS]-(foaf) " +
                "RETURN foaf.name AS name";

        return session.run(foafQuery, parameters("name","Joe"));
    }

    public StatementResult commonFriends(){
        String commonFriendsQuery =
                "MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person) " +
                "WHERE user.name = {from} AND foaf.name = {to} " +
                "RETURN friend.name AS friend";

        return session.run(commonFriendsQuery, parameters("from","Joe","to","Sally"));
    }

    public StatementResult connectingPaths(){
        String connectingPathsQuery =
                "MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person)) " +
                "WHERE p1.name = {from} AND p2.name = {to} " +
                "RETURN [n IN nodes(path) | n.name] as names";

            return session.run(connectingPathsQuery, parameters("from","Joe","to","Billy"));
    }

    public Social() {
        Neo4jConfig config = Neo4jConfigReader.get();
        Config noSSL = Config.build().withEncryptionLevel(Config.EncryptionLevel.NONE).toConfig();
        Driver driver = GraphDatabase.driver("bolt://" + config.getHost(), AuthTokens.basic(config.getUserName(),config.getPassword()),noSSL);
        session = driver.session();
    }
}
