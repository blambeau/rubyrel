module Rubyrel
  module Typing
    # 
    # Prototype module for rubyrel domains
    #
    module Domain
      
      # Checks if a given value is belongs to the domain.
      def rel_belongs?(value)
        self === value
      end
      
      # Converts a ruby literal to a valid value in the domain
      def rel_from_ruby_literal(literal)
        return literal if rel_blongs?(literal)
        raise Rubyrel::TypeError, "Unable to convert #{literal} to a #{self}"
      end
      
    end # module Domain
  end # module Typing
end # module Rubyrel
class Class
  include Rubyrel::Typing::Domain
end