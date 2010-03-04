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
    
    # Executes DDL statements
    class Executor
      
      # Creates an Executor instance with file for path resolution
      def initialize(file = nil)
        @file = file
      end

      # Lauches the DDL domain specific language on a schema
      def build(schema, &block)
        schema.__dsl_execute(@file, &block)
        schema
      end
    
      # Creates a new shema and starts DSL interpretation on it
      def schema(name, &block)
        build(Schema.new(name), &block)
      end
    
    end # class Executor
    
    # Lauches an unlocated executor 
    def schema(name, &block)
      Executor.new.schema(name, &block)
    end
    module_function :schema
    
    # Executes a DDL string, using file for path resolution
    def execute(str, file = nil)
      Executor.new(file).instance_eval(str)
    end
    module_function :execute
    
  end # module DDL
end # module Rubyrel