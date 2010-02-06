module Rubyrel
  # Relation variable inside a database
  class Relvar
    include Enumerable
    
    # Parent database
    attr_reader :db
    
    # Parent namespace
    attr_reader :namespace
    
    # The relation variable definition
    attr_reader :relvar_def
    
    # Creates a relation variable instance
    def initialize(db, namespace, relvar_def)
      @db, @namespace, @relvar_def = db, namespace, relvar_def
      @tuple = Tuple.new(relvar_def)
    end
    
    # Yields the block with each tuple inside the relvar
    def each
      return unless block_given?
      underlying_table.each{|t| yield(@tuple.send(:__set_physical,t))}
    end
    
    # Affects a value to this relation variable
    def affect(value)
      case value
        when Array
          underlying_table.delete
          value.each{|v| underlying_table.insert(v)}
        else
          raise ArgumentError, "Unable to affect #{value} to a relation variable"
      end
    end
    
    # Inspects this relvar (returns a Rel code with the content of the relvar)
    def inspect
      collect{|tuple| tuple.inspect}.join("\n")
    end
    
    # Returns the underlying table as a Sequel::Dataset object
    def underlying_table
      @underlying_table ||= db.handler[relvar_def.namespace_qualified_name(db.handler)]
    end
    
    private :underlying_table
  end # class Relvar
end # module Rubyrel