module Rubyrel
  module Algebra
    class QueryParser
    
      # Initialize on a given schema instance
      def initialize(schema)
        @schema = schema
        schema.each_namespace do |n|
          self.class.send(:define_method, n.name) {
            NamespaceRef.new(schema, n)
          }
        end
      end
      
      # Parses a given block
      def parse(&block)
        instance_eval(&block)
      end
      
    end # class QueryParser
  end # module Algebra
end # module Rubyrel