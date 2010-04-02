module Rubyrel
  module Typing
    module ConstrainedDomain
      include ::Rubyrel::Typing::Domain

      # Returns domain constraints
      def __rubyrel_domain_constraints
        @__rubyrel_domain_constraints ||= []
      end
      
      # Adds a domain constraint as a block
      def __rubyrel_add_domain_constraint(&block)
        __rubyrel_domain_constraints << block
        self
      end
      
      # Checks if a given value is belongs to the domain.
      def ===(value)
        (superclass === value) and __rubyrel_domain_constraints.all?{|c| c.call(value)}
      end
      alias :__rubyrel_belongs? :===
      
      # Converts a ruby literal to a valid value in the domain
      def __rubyrel_from_ruby_literal(literal)
        raise Rubyrel::TypeError, "Unable to convert #{literal} to a #{self}" unless __rubyrel_belongs?(literal)
        if self.respond_to?(:new)
          self.send(:new, literal) 
        else
          literal
        end
      end
      alias :[] :__rubyrel_from_ruby_literal
      
    end # module ConstrainedDomain
  end # module Typing
end # module Rubyrel 