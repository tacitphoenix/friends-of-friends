const neo4j = require('neo4j-driver').v1;
const yaml = require('js-yaml');
const fs = require('fs');

function getNeo4jDriver(configFile){
  try {
    const ncfg = yaml.safeLoad(fs.readFileSync(configFile, 'utf8'));
    const driver = neo4j.driver(`bolt://${ncfg.host}`, neo4j.auth.basic(ncfg.userName, ncfg.password));
    return driver;
  } catch(e) {
    return e;
  }
}

module.exports = getNeo4jDriver;
