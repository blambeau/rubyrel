module Rubyrel
  module DDL
    # A namespace inside a database schame
    class Namespace
      
      # Domain specific languague for namespaces
      class DSL
        
        # Creates a DSL instance for a given namespace and executes
        # the block in its context.
        def initialize(namespace, &block)
          @namespace = namespace
          self.instance_eval(&block) if block
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
      
      # Paret schema
      attr_reader :schema
      
      # Namespace name
      attr_reader :name
      
      # Relation variables by name
      attr_reader :relvars
      
      # Creates a namespace instance inside a schema with a name
      def initialize(schema, name)
        raise ArgumentError, "Invalid schema #{schema}" unless Schema===schema
        raise ArgumentError, "Invalid name #{name}" unless Symbol===name
        @schema = schema
        @name = name
        @relvars = {}
      end
      
      # Executes a DSL value on this namespace
      def __dsl_execute(&block)
        DSL.new(self, &block)
      end
      
      # Adds a relvar to this namespace
      def add_relvar(relvar)
        @relvars[relvar.name] = relvar
      end
      
      # Returns a relvar by name, creating an empty one if not found
      # and requested
      def relvar(name, create_empty = true)
        relvars[name] = Relvar.new(self,name) if not(relvars.has_key?(name)) and create_empty
        relvars[name]
      end
      
    end # class Namespace
  end # module DDL
end # module Rubyrel