module Sequel
  module Schema
    class Generator
      
      # Adds a constraint
      def rubyrel_add_constraint(opts)
        constraints << opts
      end
      
    end # class Generator
  end # module Schema
end # module Sequel