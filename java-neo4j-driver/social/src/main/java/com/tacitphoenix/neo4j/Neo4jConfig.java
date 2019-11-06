package com.tacitphoenix.neo4j;

public class Neo4jConfig {
    private String userName;
    private String password;
    private String host;
    private Integer boltPort;
    private Integer httpPort;
    private Integer httpsPort;

    public Neo4jConfig() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public Integer getBoltPort() {
        return boltPort;
    }

    public void setBoltPort(Integer boltPort) {
        this.boltPort = boltPort;
    }

    public Integer getHttpPort() {
        return httpPort;
    }

    public void setHttpPort(Integer httpPort) {
        this.httpPort = httpPort;
    }

    public Integer getHttpsPort() {
        return httpPort;
    }

    public void setHttpsPort(Integer httpPort) {
        this.httpPort = httpPort;
    }
}
