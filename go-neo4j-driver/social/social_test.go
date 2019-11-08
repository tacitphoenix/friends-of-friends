package social

import (
	"testing"
)

func TestTryGraph(t *testing.T) {
	var want string = "Item 1"
	result, err := TryGraph()
	if err != nil {
		t.Errorf(err.Error())
	}
	for result.Next() {
		got := result.Record().Values()[1].(string)
		if got != want {
			t.Errorf("Graph = %v, want %v", got, want)
		}
	}
}
