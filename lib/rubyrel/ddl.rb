require 'rubyrel/ddl/attribute'
require 'rubyrel/ddl/foreign_key'
require 'rubyrel/ddl/key'
require 'rubyrel/ddl/namespace'
require 'rubyrel/ddl/relvar'
require 'rubyrel/ddl/schema'
module Rubyrel
  module DDL
    
    # Lauches the DDL domain specific language on a schema
    def build(schema, &block)
      schema.__dsl_execute(&block)
      schema
    end
    module_function :build
    
    # Creates a new shema and starts DSL interpretation on it
    def schema(name, &block)
      build(Schema.new(name), &block)
    end
    module_function :schema
    
  end # module DDL
end # module Rubyrel