package social

import (
	"io/ioutil"
	"log"

	"gopkg.in/yaml.v2"
)

type Neo4jConfig struct {
	Username  string `yaml:"userName"`
	Password  string
	Host      string
	BoltPort  string `yaml:"boltPort"`
	HttpPort  string `yaml:"httpPort"`
	HttpsPort string `yaml:"httpsPort"`
}

func GetNeo4jConfig(configFile string) Neo4jConfig {
	var config Neo4jConfig
	data, err := ioutil.ReadFile(configFile)
	if err != nil {
		log.Fatal(err)
	}

	if err = yaml.Unmarshal(data, &config); err != nil {
		log.Fatal(err)
	}

	return config
}
