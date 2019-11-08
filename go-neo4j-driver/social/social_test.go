package social

import "testing"

var configFile = "../../config.yml"

func TestUsername(t *testing.T) {
	want := "neo4j"
	if got := GetNeo4jConfig(configFile); got.Username != want {
		t.Errorf("config.Username = %q, want %q", got.Username, want)
	}
}

func TestHost(t *testing.T) {
	want := "localhost"
	if got := GetNeo4jConfig(configFile); got.Host != want {
		t.Errorf("config.Host = %q, want %q", got.Host, want)
	}
}

func TestHttpPort(t *testing.T) {
	want := "7474"
	if got := GetNeo4jConfig(configFile); got.HttpPort != want {
		t.Errorf("config.HttpPort = %q, want %q", got.HttpPort, want)
	}
}

func TestHttpsPort(t *testing.T) {
	want := "7473"
	if got := GetNeo4jConfig(configFile); got.HttpsPort != want {
		t.Errorf("config.HttpsPort = %q, want %q", got.HttpsPort, want)
	}
}

func TestBoltPort(t *testing.T) {
	want := "7687"
	if got := GetNeo4jConfig(configFile); got.BoltPort != want {
		t.Errorf("config.BoltPort = %q, want %q", got.BoltPort, want)
	}
}
