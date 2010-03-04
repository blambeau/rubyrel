module Rubyrel
  module DDL
    # Definition of a relation variable
    class Relvar
      
      # Parent namespace
      attr_reader :namespace
      
      # Relation variable name
      attr_reader :name
      
      # Relation attributes
      attr_reader :attributes
      
      # Relation primary key
      attr_reader :primary_key
      
      # Relation candidate keys
      attr_reader :candidate_keys
      
      # Relation foreign keys
      attr_reader :foreign_keys
      
      # Creates a relation variable inside a namespace
      def initialize(namespace, name)
        raise ArgumentError, "Invalid namespace #{namespace}" unless Namespace===namespace
        raise ArgumentError, "Invalid name #{name}" unless Symbol===name
        @namespace, @name = namespace, name
        @attributes  = {}
        @primary_key = nil
        @candidate_keys = {}
        @foreign_keys = {}
      end
      
      # Executes a DSL value on this namespace
      def __dsl_execute(&block)
        DSL.new(self, &block)
      end
      
      ############################################################### Query utilities
      
      # Returns an attribute by its name. If raise_if_unfound is set to true,
      # raises an error if the attribute cannot be found, returns nil otherwise 
      # in this case.
      def attribute(name, raise_if_unfound = false)
        return name if Attribute===name
        a = attributes[name]
        raise "No such attribute #{name}" if a.nil? and raise_if_unfound
        a
      end
      
      # Collects some attributes by their name
      def attributes(*names)
        return @attributes if names.empty?
        names.collect{|name| attribute(name, true)}
      end
      
      # Returns a candidate key by its name. If raise_if_unfound is set to true,
      # raises an error if the key cannot be found, returns nil otherwise 
      # in this case.
      def candidate_key(name, raise_if_unfound = false)
        return name if Key===name
        k = candidate_keys[name]
        raise "No such candidate key #{name}" if k.nil? and raise_if_unfound
        k
      end
      
      ############################################################### Modification utilities
      
      # Adds an attribute to the relation variable
      def add_attribute(name, domain, options = {})
        a = Attribute.new(self, name, domain, options)
        attributes[name] = a
      end
      
      # Adds a candidate key on some attributes
      def add_candidate_key(name, attributes)
        candidate_keys[name] = Key.new(self, name, attributes)
      end
      
      # Mark a given candidate key as being the primary key.
      def set_primary_key(key)
        @primary_key.primary = false if @primary
        @primary_key = key
        @primary_key.primary = true
        @primary_key
      end
      
      # Adds a foreign key
      def add_foreign_key(name, attributes, target)
        fk = ForeignKey.new(self, name, attributes, target)
        foreign_keys[name] = fk
        fk
      end
      
      # Yields the block with each attribute in turn
      def each_attribute
        attributes.each_pair{|name,a| yield(a) if block_given?}
      end
      
      # Yields the block with each candidate key in turn
      def each_candidate_key
        candidate_keys.each_pair{|name,k| yield(k) if block_given?}
      end
      
      # Yields the block with each foreign key in turn
      def each_foreign_key
        foreign_keys.each_pair{|name,k| yield(k) if block_given?}
      end
      
    end # class Relvar
  end # module DDL
end # module Rubyrel