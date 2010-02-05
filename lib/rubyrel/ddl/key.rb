module Rubyrel
  module DDL
    # Candidate key of a relation variable
    class Key
      
      # Parent relation variable
      attr_reader :relvar
      
      # Constraint name
      attr_reader :name
      
      # Attributes of the key
      attr_reader :attributes
      
      # Is this key a primary key?
      attr_accessor :primary
      
      # Creates a key instance
      def initialize(relvar, name, attributes, primary = false)
        raise ArgumentError, "Invalid relvar #{relvar}" unless Relvar === relvar
        raise ArgumentError, "Invalid key name #{name}" unless String === name
        raise ArgumentError, "Invalid attributes #{attributes.all?}" unless attributes.all?{|a| Attribute===a}
        @relvar, @name, @attributes = relvar, name, attributes
        @primary = false
      end
      
      # Is this key a primary key?
      def primary?
        @primary
      end
      
      # Returns the number of attributes that participate to the key.
      def size
        attributes.size
      end
      
    end # class Key
  end # module DDL
end # module Rubyrel
