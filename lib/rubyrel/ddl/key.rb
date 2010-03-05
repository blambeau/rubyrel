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
      
      # Converts this key definition as a rel catalog tuple
      def __to_catalog_tuple
        {:namespace  => relvar.namespace.name.to_s, 
         :relvar     => relvar.name.to_s, 
         :name       => name.to_s, 
         :primary    => primary}
      end

      # Saves this namespace inside a relational database      
      def __save_on_database(db, t)
        tuple = __to_catalog_tuple
        t.rubyrel_catalog.candidate_keys << tuple
        t.rubyrel_catalog.candidate_key_attributes << attributes.collect{|a|
          {:namespace  => relvar.namespace.name.to_s, 
           :relvar     => relvar.name.to_s, 
           :key        => name.to_s,
           :attribute  => a.name.to_s} 
        }
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
