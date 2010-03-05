module Rubyrel
  module DDL
    # Database schema definition
    class Schema
      
      # Domain Specific Language for schemas
      class DSL
        include DSLCommons
        
        # Creates a dsl instance and executes the block in its context 
        def initialize(schema, file = nil, &block)
          @schema = schema
          @file = file
          if block 
            instance_eval(&block)
          elsif file
            instance_eval(File.read(file))
          end
        end
        
        # Returns the main object populated by this DSL
        def __main_object
          @schema
        end
        
        # Returns the current schema under construction
        def __schema
          @schema
        end
      
        # Delegated to the current namespace if any
        def method_missing(name, *args, &block)
          if @current_namespace and @current_namespace.respond_to?(name)
            obj = @current_namespace.send(name, *args, &block)
            obj.__dsl_execute(&block)
          else
            super(name, *args, &block)
          end
        end
        
        # Loads an extension
        def extension(name)
          extension_file = File.join(File.dirname(@file), "#{name}.rel")
          instance_eval(File.read(extension_file))
        end
      
        # Opens a namespace, creating an empty one if not already created.
        # Executes the block in the context of the namespace DSL
        def namespace(namespace_name, create_empty = true, &block)
          n = @schema.namespace(namespace_name, create_empty)
          raise ArgumentError, "No such namespace #{namespace_name}" unless n
          if block
            n.__dsl_execute(&block) if block
          else
            @current_namespace = n
          end
        end
        
        # Simply returns self
        def schema
          self
        end
        
      end # class DSL
      
    end # class Schema
  end # module DDL
end # module Rubyrel