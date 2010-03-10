module Rubyrel
  class Database
    
    # The database schema
    attr_reader :schema
    
    # The database handler (a Sequel::Database instance)
    attr_reader :handler
    
    # Database namespaces
    attr_reader :namespaces
    
    # Creates a database instance with a given schema and a Sequel::Database
    # instance as handler
    def initialize(schema, handler)
      @schema, @handler = schema, handler
      populate!
    end
    
    # Populates the class with namespaces and relation variables
    def populate!
      @namespaces = {}
      schema.each_namespace {|n| 
        namespaces[n.name] = Namespace.new(self,n)
        self.instance_eval <<-EOF
          def #{n.name}
            namespaces[:#{n.name}]
          end
        EOF
      }
    end
    
    # Encapsultes block execution inside a transaction
    def transaction
      handler.transaction do 
        yield self
      end
    end
    
    # Returns a namespace by its name. If raise_on_unfound is set to true, raise
    # an error if the namespace cannot be found. Returns nil otherwise.
    def namespace(name, raise_on_unfound = true)
      raise "Unknown namespace #{name}" unless namespaces.has_key?(name) and raise_on_unfound
      namespaces[name]
    end
    
    private :populate!
  end # class Database
end # module Rubyrel