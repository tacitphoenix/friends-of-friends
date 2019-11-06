require 'openssl'
require 'yaml'
require 'neo4j-core'
require 'neo4j/core/cypher_session/adaptors/http'

module Neo4jInit
    def self.getSession(config_file)
        if File.file?(config_file)
            # Read file and construct connection string
            neo = YAML.load(File.read(config_file))
            conn_str = "http://#{neo['username']}:#{neo['password']}@#{neo['host']}:#{neo['http_port']}"
        else
            abort "Configuration file config.yml not found"
        end
        
        puts "Neo4j Connection String: #{conn_str}"
        # Use HTTP adapter to create session
        http_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new(conn_str, {})
        Neo4j::Core::CypherSession.new(http_adaptor)
    end
end
