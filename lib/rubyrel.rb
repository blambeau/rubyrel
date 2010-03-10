require 'rubygems'
require 'sequel'
require 'rubyrel/errors'
require 'rubyrel/ext'
require 'rubyrel/ddl'
require 'rubyrel/database'
require 'rubyrel/namespace'
require 'rubyrel/relvar'
require 'rubyrel/tuple'
module Rubyrel
  
  # Current Rubyrel version
  VERSION = "0.0.1".freeze
  
  # Regular expression for checking all named things
  NAMED_REGEX = /^[a-z][a-z0-9_]*$/
  
  # Regular expression for checking all named things
  QUALIFIED_NAMED_REGEX = /^([a-z][a-z0-9_]*)\.([a-z][a-z0-9_]*)$/
  
  # Location of the catalog rel file
  RUBYREL_CATALOG_FILE = File.join(File.dirname(__FILE__), 'rubyrel', 'catalog', 'rubyrel_catalog.rel')
  
  # Parses and executes a schema definition given by a block
  def parse_ddl(name, &block) 
    Rubyrel::DDL.schema(name, &block)
  end
  module_function :parse_ddl
  
  # Parses a DDL file
  def parse_ddl_file(file)
    Rubyrel::DDL.schema(File.basename(file, '.rel'), file)
  end
  module_function :parse_ddl_file
  
  # Extends a schema with a file or a block
  def extend_schema(schema, file = nil, &block)
    Rubyrel::DDL::extend_schema(schema, file, &block)
  end
  module_function :extend_schema
  
  # Connect a database given a physical handler
  def connect(handler) 
    sequel_db = ::Sequel.connect(handler)
    schema = Rubyrel::DDL::Schema.new(:noname)
    schema.__load_from_database(sequel_db)
    ::Rubyrel::Database.new(schema, sequel_db)
  end
  module_function :connect
  
end