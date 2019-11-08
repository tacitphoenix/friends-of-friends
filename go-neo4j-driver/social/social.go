package social

import (
	"fmt"

	"github.com/neo4j/neo4j-go-driver/neo4j"
)

var (
	session neo4j.Session
	result  neo4j.Result
)

func TryGraph() (neo4j.Result, error) {
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

	result, err = session.Run("CREATE (n:Item { id: $id, name: $name }) RETURN n.id, n.name", map[string]interface{}{
		"id":   1,
		"name": "Item 1",
	})
	if err != nil {
		return nil, err // handle error
	}

	return result, nil
}
