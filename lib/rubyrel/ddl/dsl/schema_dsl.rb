module Rubyrel
  module DDL
    # Database schema definition
    class Schema
      
      # Domain Specific Language for schemas
      class DSL
        include DSLCommons
        
        # Creates a dsl instance and executes the block in its context 
        def initialize(schema, &block)
          @schema = schema
          instance_eval(&block) if block
        end
        
        # Returns the main object populated by this DSL
        def __main_object
          @schema
        end
      
        # Opens a namespace, creating an empty one if not already created.
        # Executes the block in the context of the namespace DSL
        def namespace(namespace_name, create_empty = true, &block)
          n = @schema.namespace(namespace_name, create_empty)
          raise ArgumentError, "No such namespace #{namespace_name}" unless n
          n.__dsl_execute(&block) if block
          n
        end
        
        # Simply returns self
        def schema
          self
        end
        
      end # class DSL
      
    end # class Schema
  end # module DDL
end # module Rubyrel