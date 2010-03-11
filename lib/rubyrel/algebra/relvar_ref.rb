module Rubyrel
  module Algebra
    #
    # Reference to a relation variable through its name
    #
    class RelvarRef < Operator
      
      # Creates an operator instance
      def initialize(schema, relvar)
        @schema, @relvar = schema, relvar
      end
      
    end # class RelvarRef
  end # module Algebra
end # module Rubyrel