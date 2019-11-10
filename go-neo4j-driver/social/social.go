package social

import (
	"fmt"

	"github.com/neo4j/neo4j-go-driver/neo4j"
)

var (
	session neo4j.Session
	result  neo4j.Result
)

func RunQuery(cypher string, params map[string]interface{}) (neo4j.Result, error) {
	driver, err := SocialDriver()
	if err != nil {
		return nil, err
	}
	defer driver.Close()

	if session, err = driver.Session(neo4j.AccessModeWrite); err != nil {
		fmt.Println(err)
		return nil, err
	}
	defer session.Close()

	result, err = session.Run(cypher, params)
	if err != nil {
		return nil, err
	}

	return result, nil
}

func InsertFriends() (neo4j.Result, error) {
	query := `
	UNWIND $pairs as pair
	MERGE (p1:Person {name:pair[0]})
	MERGE (p2:Person {name:pair[1]})
	MERGE (p1)-[:KNOWS]-(p2);
	`
	data := []map[string]interface{}{{"Jim": "Mike"}, {"Jim": "Billy"}, {"Anna": "Jim"},
		{"Anna": "Mike"}, {"Sally": "Anna"}, {"Joe": "Sally"},
		{"Joe": "Bob"}, {"Bob": "Sally"}}

	params := map[string]interface{}{"pairs": data}
	result, err := RunQuery(query, params)
	if err != nil {
		return nil, err
	}
	return result, err
}

func CommonFriends() (neo4j.Result, error) {
	query := `
	MATCH (user:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf:Person)
	WHERE user.name = $user AND foaf.name = $foaf
	RETURN friend.name AS friend
	`
	params := map[string]interface{}{"user": "Joe", "foaf": "Sally"}
	result, err := RunQuery(query, params)
	if err != nil {
		return nil, err
	}
	return result, err
}

func ConnectingPaths() (neo4j.Result, error) {
	query := `
	MATCH path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))
	WHERE p1.name = $name1 AND p2.name = $name2
	RETURN path
	`
	params := map[string]interface{}{"name1": "Joe", "name2": "Billy"}
	result, err := RunQuery(query, params)
	if err != nil {
		return nil, err
	}
	return result, err
}

func FriendsOfAFriend() (neo4j.Result, error) {
	query := `
	MATCH (person:Person)-[:KNOWS]-(friend)-[:KNOWS]-(foaf) 
	WHERE person.name = $name
  	AND NOT (person)-[:KNOWS]-(foaf)
	RETURN foaf.name AS name
	`
	params := map[string]interface{}{"name": "Joe"}
	result, err := RunQuery(query, params)
	if err != nil {
		return nil, err
	}
	return result, err
}
