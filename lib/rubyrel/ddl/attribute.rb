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
      
      # Attribute options (default values and so on)
      attr_reader :options
      
      # Creates an attribute instance
      def initialize(relvar, name, domain, options = {})
        raise ArgumentError, "Invalid relvar #{relvar}" unless Relvar === relvar
        raise ArgumentError, "Invalid attribute name #{name}" unless Symbol === name
        raise ArgumentError, "Invalid domain #{domain}" unless Class === domain
        raise ArgumentError, "Invalid options #{options.inspect}" unless Hash === options
        @relvar, @name, @domain, @options = relvar, name, domain, options
      end
      
    end # class Attribute
  end # module DDL
end # module Rubyrel