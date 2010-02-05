module Rubyrel
  module DDL
    # Attribute inside a relation variable (heading)
    class Attribute
      
      # Containing relation variable
      attr_reader :relvar
      
      # Name of the attribute
      attr_reader :name
      
      # Domain of the attribute
      attr_reader :domain
      
      # Creates an attribute instance
      def initialize(relvar, name, domain)
        raise ArgumentError, "Invalid relvar #{relvar}" unless Relvar === relvar
        raise ArgumentError, "Invalid attribute name #{name}" unless Symbol === name
        raise ArgumentError, "Invalid domain #{domain}" unless Class === domain
        @relvar, @name, @domain = relvar, name, domain
      end
      
    end # class Attribute
  end # module DDL
end # module Rubyrel