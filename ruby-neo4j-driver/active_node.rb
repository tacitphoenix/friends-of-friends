require './neo4j_init'
require 'neo4j'

# Get session
session = Neo4jInit.getSession("../config.yml")

# ActiveNode models:
Neo4j::ActiveBase.current_session = session

session.query('CREATE CONSTRAINT ON (p:Person) ASSERT p.uuid IS UNIQUE')

class Person
  include Neo4j::ActiveNode
  property :name

  has_many :in, :known_people, type: :KNOWS, model_class: :Person
end

puts Person.where(name: 'Joe').query_as(:p1).match('path = shortestPath((p1:Person)-[:KNOWS*..6]-(p2:Person))').where(p2: {name: 'Billy'}).pluck('nodes(path)').first.map(&:name)