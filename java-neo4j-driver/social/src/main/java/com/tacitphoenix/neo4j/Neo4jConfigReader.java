package com.tacitphoenix.neo4j;

import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.io.InputStream;

public class Neo4jConfigReader {
    public static Neo4jConfig get() {
        Yaml yaml = new Yaml(new Constructor(Neo4jConfig.class));
        InputStream inputStream = Neo4jConfigReader.class.getClassLoader().getResourceAsStream("config.yml");
        Neo4jConfig config = yaml.load(inputStream);
        return config;
    }
}
