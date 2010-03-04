module Rubyrel
  module Algebra
    
    # OPERAND RENAME {oldattr1 newattr1, ...}
    class Rename < Operator
      
      # Main operand
      attr_reader :operand
      
      # Hash mapping old to new attribute names
      attr_reader :renaming
      
      # Creates a Rename operator instance
      def initialize(operand, renaming)
        @operand, @renaming = operand, renaming
      end
      
    end # class Rename
    
  end # module Algebra
end # module Rubyrel