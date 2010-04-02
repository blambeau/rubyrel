module Rubyrel
  module Typing
    module TupleDomain
      
      # Returns the tuple heading
      def heading
        @heading
      end
      
      # Converts a ruby hash to a tuple value
      def rel_from_ruby_literal(pairs)
        new_pairs = {}
        heading.each{|a|
          raise TypeError, "Unable to convert #{pairs.inspect} to #{self}"\
            unless pairs.has_key?(a.name)
          new_pairs[a.name] = a.domain.rel_from_ruby_literal(pairs[a.name])  
        }
        self.send(:new, new_pairs)
      end
      alias :[] :rel_from_ruby_literal
      
    end # module TupleDomain
  end # module Typing
end # module Rubyrel