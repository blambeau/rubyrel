module Rubyrel
  module Typing
    module TupleDomain
      
      # Returns the tuple heading
      def heading
        @heading
      end
      
      # Converts a ruby hash to a tuple value
      def rel_from_ruby_literal(pairs)
        raise TypeError, "Unable to convert #{pairs.inspect} to #{self}"\
          unless heading.valid_ruby_literal?(pairs)
        self.send(:new, pairs)
      end
      alias :[] :rel_from_ruby_literal
      
    end # module TupleDomain
  end # module Typing
end # module Rubyrel