package social

import (
	"fmt"
	"io/ioutil"

	"github.com/neo4j/neo4j-go-driver/neo4j"
	"gopkg.in/yaml.v2"
)

var neo4jConfigFile = "../../config.yml"

type Neo4jConfig struct {
	Username  string `yaml:"userName"`
	Password  string
	Host      string
	BoltPort  string `yaml:"boltPort"`
	HttpPort  string `yaml:"httpPort"`
	HttpsPort string `yaml:"httpsPort"`
}

func SocialDriver() (neo4j.Driver, error) {

	var (
		driver neo4j.Driver
		config Neo4jConfig
	)

	data, err := ioutil.ReadFile(neo4jConfigFile)
	if err != nil {
		return nil, err
	}

	if err = yaml.Unmarshal(data, &config); err != nil {
		return nil, err
	}

	url := fmt.Sprintf("bolt://%s:%s", config.Host, config.BoltPort)
	if driver, err = neo4j.NewDriver(url, neo4j.BasicAuth(config.Username, config.Password, "")); err != nil {
		fmt.Println(err)
		return nil, err
	}

	return driver, nil
}
