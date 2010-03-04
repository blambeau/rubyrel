module Rubyrel
  module Algebra
    #
    # Reference to a relation variable through its name
    #
    class RelvarRef < Operator
      
      # Name of the referenced relation variable
      attr_reader :relvar_name
      
      # Creates an operator instance
      def initialize(relvar_name)
        @relvar_name = relvar_name
      end
      
    end # class RelvarRef
  end # module Algebra
end # module Rubyrel