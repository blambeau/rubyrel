module Rubyrel
  module Typing
    class Attribute
      
      # Attribute name
      attr_reader :name
      
      # Attribute domain
      attr_reader :domain
      
      # Attribute options
      attr_reader :options
      
      # Creates an attribute instance
      def initialize(name, domain, options = {})
        raise ArgumentError, "Invalid attribute name #{name}" unless Symbol === name
        raise ArgumentError, "Invalid domain #{domain}" unless Class === domain
        raise ArgumentError, "Invalid options #{options.inspect}" unless Hash === options
        @name, @domain, @options = name, domain, options.freeze
      end
    
      # Returns an hash code for this attribute  
      def hash
        37*37*name.hash + 37*domain.hash + Rubyrel::Utils.hash(options)
      end
      
      def ==(other)
        return false unless other.is_a? Attribute
        (name == other.name) && (domain == other.domain) && (options == other.options)
      end
      
    end # class Attribute
  end # module Typing
end # module Rubyrel