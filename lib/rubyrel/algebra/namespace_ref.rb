module Rubyrel
  module Algebra
    #
    # Reference to a namespace through its name
    #
    class NamespaceRef
      
      # Creates an operator instance
      def initialize(schema, namespace)
        @schema, @namespace = schema, namespace
        populate!
      end
      
      # Populates this namespace reference 
      def populate!
        @namespace.each_relvar do |r|
          self.class.send(:define_method, r.name) {
            RelvarRef.new(@schema, r)
          }
        end
      end
      
      private :populate!
    end # class RelvarRef
  end # module Algebra
end # module Rubyrel