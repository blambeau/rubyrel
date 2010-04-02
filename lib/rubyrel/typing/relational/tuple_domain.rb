module Rubyrel
  module Typing
    module TupleDomain
      
      # Returns the tuple heading
      def heading
        @heading
      end
      
      def __rubyrel_belongs?(value)
        (self === value)
      end
      
      def __rubyrel_convert_ruby_literal(pairs)
        new_pairs = {}
        heading.each{|a|
          raise TypeError, "Unable to convert #{pairs.inspect} to #{self}"\
            unless pairs.has_key?(a.name)
          new_pairs[a.name] = a.domain.__rubyrel_from_ruby_literal(pairs[a.name])  
        }
        new_pairs
      end
      
      # Converts a ruby hash to a tuple value
      def __rubyrel_from_ruby_literal(pairs)
        self.send(:new, __rubyrel_convert_ruby_literal(pairs))
      end
      alias :[] :__rubyrel_from_ruby_literal
      
      def to_s
        "Rubyrel::Typing::tuple_domain#{heading.inspect}"
      end
      alias :inspect :to_s
      
    end # module TupleDomain
  end # module Typing
end # module Rubyrel