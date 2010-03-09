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
    
    # Clears the relation variable
    def empty!
      underlying_table.delete
    end
    
    # Inserts some tuples
    def <<(tuples)
      case tuples
        when Array
          underlying_table.multi_insert(tuples)
        when Hash
          underlying_table.insert(tuples)
        else
          raise ArgumentError, "Unable to insert #{tuples} inside a relation variable"
      end
    end
    
    # Returns true if this relvar contains a given tuple, false otherwise
    def contains?(tuple)
      case tuple
        when Hash
          eql_hash = {}
          relvar_def.primary_key.attributes.each{|a| eql_hash[a.name] = tuple[a.name]}
          inside_tuple = underlying_table.filter(eql_hash).first
          return inside_tuple === tuple
        else
          raise ArgumentError, "Unable to check inclusion of #{tuple} inside a relation variable"
      end
    end
    
    # Checks equality with a given value
    def ==(value)
      case value
        when Array
          value.size == underlying_table.count && value.all?{|h| self.contains?(h)}
        else
          raise ArgumentError, "Unable to compare #{value} to a relation variable"
      end
    end
    
    # Inspects this relvar (returns a Rel code with the content of the relvar)
    def to_tutorial_d
      buffer = relvar_def.to_tutorial_d << "{\n"
      each{|t| buffer << "  " << t.to_tutorial_d(relvar_def) << "\n"}
      buffer << "}"
      buffer
    end
    alias :inspect :to_tutorial_d
    
    # Returns the underlying table as a Sequel::Dataset object
    def underlying_table
      @underlying_table ||= db.handler[relvar_def.namespace_qualified_name(db.handler)]
    end
    
    private :underlying_table
  end # class Relvar
end # module Rubyrel