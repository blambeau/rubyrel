require 'rubyrel/ddl/dsl'
require 'rubyrel/ddl/attribute'
require 'rubyrel/ddl/foreign_key'
require 'rubyrel/ddl/key'
require 'rubyrel/ddl/namespace'
require 'rubyrel/ddl/relvar'
require 'rubyrel/ddl/schema'
require 'rubyrel/ddl/to_sql'
module Rubyrel
  module DDL
        
    # Extends a schema by executing a given .rel file on it
    def extend_schema(schema, file = nil, &block)
      schema.__dsl_execute(file, &block)
      schema
    end
    module_function :extend_schema
    
    # Lauches an unlocated executor 
    def schema(name, file=nil, &block)
      extend_schema(Schema.new(name), file, &block)
    end
    module_function :schema
    
  end # module DDL
end # module Rubyrel