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
      
      # Dumps this attribute definition as a rel catalog tuple
      def __to_catalog_tuple
        {:namespace => relvar.namespace.name, 
         :relvar    => relvar.name, 
         :name      => name, 
         :domain    => domain.to_s,
         :default   => default_value.nil? ? nil : domain.__rubyrel_to_physical_value(default_value)}
      end
      
      # Saves this namespace inside a relational database      
      def __save_on_database(db, t)
        t.rubyrel_catalog.base_relvar_attributes << __to_catalog_tuple
      end
      
      # Creates an attribute instance
      def initialize(relvar, name, domain, options = {})
        raise ArgumentError, "Invalid relvar #{relvar}" unless Relvar === relvar
        raise ArgumentError, "Invalid attribute name #{name}" unless Symbol === name
        raise ArgumentError, "Invalid domain #{domain}" unless Class === domain
        raise ArgumentError, "Invalid options #{options.inspect}" unless Hash === options
        @relvar, @name, @domain, @options = relvar, name, domain, options
      end
      
      # Returns the default value to use
      def default_value(relvar, tuple)
        case d = options[:default]
          when ::Rubyrel::Defaults::DefaultHandler
            d.compute_value(relvar, self, tuple)
          else
            d
        end
      end
      
    end # class Attribute
  end # module DDL
end # module Rubyrel