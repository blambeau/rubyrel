module Rubyrel
  module Typing
    module BuiltinDomain
      include ::Rubyrel::Typing::Domain
      
      def __rubyrel_belongs?(value)
        (self === value)
      end
  
      # Converts a ruby literal to a valid value in the domain
      def __rubyrel_from_ruby_literal(literal)
        return literal if __rubyrel_belongs?(literal)
        raise Rubyrel::TypeError, "Unable to convert #{literal} to a #{self}"
      end

    end # module BuiltinDomain
  end # module Typing
end # module Rubyrel