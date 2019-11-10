package social

import (
	"fmt"
	"testing"

	"github.com/neo4j/neo4j-go-driver/neo4j"
)

func TestInsertFriends(t *testing.T) {
	var want string = "Bob"
	result, err := InsertFriends()
	if err != nil {
		t.Errorf(err.Error())
	}
	for result.Next() {
		record := result.Record()
		fmt.Printf("%#v\n", record)
		got := record.Values()[0].(string)
		if got != want {
			t.Errorf("Person = %v, want %v", got, want)
		}
	}
}

func TestCommonFriends(t *testing.T) {
	var want string = "Bob"
	result, err := CommonFriends()
	if err != nil {
		t.Errorf(err.Error())
	}
	for result.Next() {
		record := result.Record()
		fmt.Printf("%#v\n", record)
		got := record.Values()[0].(string)
		if got != want {
			t.Errorf("Person = %v, want %v", got, want)
		}
	}
}

func TestConnectingPaths(t *testing.T) {
	var want string = "Person"
	result, err := ConnectingPaths()
	if err != nil {
		t.Errorf(err.Error())
	}
	for result.Next() {
		record := result.Record()
		fmt.Printf("%#v\n", record)
		got := record.Values()[0].(neo4j.Path).Nodes()[0].Labels()[0]
		if got != want {
			t.Errorf("Person = %v, want %v", got, want)
		}
	}
}

func TestFriendsOfAFriend(t *testing.T) {
	var want string = "Anna"
	result, err := FriendsOfAFriend()
	if err != nil {
		t.Errorf(err.Error())
	}
	for result.Next() {
		record := result.Record()
		fmt.Printf("%#v\n", record)
		got := record.Values()[0].(string)
		if got != want {
			t.Errorf("Person = %v, want %v", got, want)
		}
	}
}
