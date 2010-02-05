module Rubyrel
  module DDL
    # A namespace inside a database schame
    class Namespace
      
      # Domain specific languague for namespaces
      class DSL
        include DSLCommons
        
        # Creates a DSL instance for a given namespace and executes
        # the block in its context.
        def initialize(namespace, &block)
          @namespace = namespace
          self.instance_eval(&block) if block
        end
        
        # Returns the main object populated by this DSL
        def __main_object
          @namespace
        end
      
        # Creates or reopens a relation variable definition
        # and executes the block inside its DSL context
        def relvar(name, create_empty = true, &block) 
          relvar = @namespace.relvar(name, create_empty)
          raise ArgumentError, "No such relvar #{name}" unless relvar
          relvar.__dsl_execute(&block)
          relvar
        end
        
      end # class DSL
      
    end # class Namespace
  end # module DDL
end # module Rubyrel