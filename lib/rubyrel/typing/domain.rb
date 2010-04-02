module Rubyrel
  module Typing
    # Marker module for rubyrel domains
    module Domain
      
      # Returns true if _value_ is belongs to the domain, false otherwise
      def __rubyrel_belongs?(value)
        raise NotImplementedError, "Domain #{self} should implement __rubyrel_belongs?"
      end
  
      # Converts a ruby literal to a valid value in the domain.
      # Raises a ::Rubyrel::TypeError if the literal may not be converted to 
      # a value that belongs to the domain
      def __rubyrel_from_ruby_literal(literal)
        raise NotImplementedError, "Domain #{self} should implement __rubyrel_from_ruby_literal"
      end

    end # module Domain
  end # module Typing
end # module Rubyrel
