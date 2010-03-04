module Rubyrel
  module Algebra
    #
    # Implements relational projection
    #
    # In tutorial D:
    #   OPERAND {attr1, attr2, ...}
    #   OPERAND {ALL BUT attr1, attr2, ...}
    #
    class Project < Operator
      
      # Main projection operand
      attr_reader :operand
      
      # All but projection?
      attr_reader :allbut
      
      # Attributes on which the projection takes place 
      attr_reader :attribute_names
      
      # Creates an operator instance
      def initialize(operand, attribute_names, allbut = false)
        @operand, @attribute_names, @allbut =  operand, attribute_names, allbut
      end
      
    end # class Project
  end # module Algebra
end # module Rubyrel