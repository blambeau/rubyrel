module Rubyrel
  module Algebra
    # Provides a common module for all operands of the relational 
    # algebra
    module Operand
      
      # Projection on attributes
      def project(*attributes)
        Project.new(self, attributes, false)
      end
      
      # Allbut projection on attributes
      def allbut(*attributes)
        Project.new(self, attributes, true)
      end
      
      # Renaming of some attributes
      def rename(renaming)
        Rename.new(self, renaming)
      end
      
    end # module Operand 
  end # module Algebra
end # module Rubyrel