module Sequel
  module Schema
    class Generator
      
      # Adds a constraint
      def rubyrel_add_constraint(opts)
        constraints << opts
      end
      
    end # class Generator
    class AlterTableGenerator
      
      # Adds an operation
      def rubyrel_add_operation(opts)
        @operations << opts
      end
      
    end # class AlterTableGenerator
  end # module Schema
end # module Sequel