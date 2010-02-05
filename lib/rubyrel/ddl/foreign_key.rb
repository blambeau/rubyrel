module Rubyrel
  module DDL
    # Foreign key of a relation variable
    class ForeignKey
      
      # Parent relation variable
      attr_reader :relvar
      
      # Constraint name
      attr_reader :name
      
      # Source attributes of the key
      attr_reader :attributes
      
      # Target key
      attr_reader :target
      
      # Creates a key instance
      def initialize(relvar, name, attributes, target)
        raise ArgumentError, "Invalid relvar #{relvar}" unless Relvar === relvar
        raise ArgumentError, "Invalid foreign key name #{name}" unless String === name
        raise ArgumentError, "Invalid attributes #{attributes.all?}" unless attributes.all?{|a| Attribute===a}
        raise ArgumentError, "Invalid foreign key target #{target}" unless Key===target and target.size==attributes.size
        @relvar, @name, @attributes, @target = relvar, name, attributes, target
      end
      
    end # class ForeignKey
  end # module DDL
end # module Rubyrel
