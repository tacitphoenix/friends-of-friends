package com.tacitphoenix.neo4j;

import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

public class Neo4jConfigReader {
    public static Neo4jConfig get() {
        Neo4jConfig config = null;
        try {
            Yaml yaml = new Yaml(new Constructor(Neo4jConfig.class));
            File file = new File(Neo4jConfigReader.class.getClassLoader().getResource("config.yml").getFile());
            InputStream inputStream = new FileInputStream(file);
            config = yaml.load(inputStream);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return config;
    }
}
