module Rubyrel
  module DDL
    # Database schema definition
    class Schema
      
      # Schema name
      attr_reader :name
      
      # Schema namespaces (names => Namespace instances)
      attr_reader :namespaces
      
      # Creates a schema with a name
      def initialize(name)
        @name = name
        @namespaces = {}
      end
      
      # Executes a DSL value on this schema
      def __dsl_execute(&block)
        DSL.new(self, &block)
      end
      
      # Returns a namespace by its name, creating an empty one if requested.
      def namespace(name, create_empty = true)
        namespaces[name] = Namespace.new(self, name) if not(namespaces.has_key?(name)) and create_empty
        namespaces[name]
      end
      
      # Adds a namespace to this schema
      def add_namespace(namespace) 
        @namespaces[namespace.name] = namespace
      end
      
    end # class Schema
  end # module DDL
end # module Rubyrel