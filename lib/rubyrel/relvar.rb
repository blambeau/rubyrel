module Rubyrel
  # Common instance methods
  module CommonRelvarMethods
    include Enumerable

    # Returns attributes names of this relation variable
    def attribute_names
      relvar_def.attribute_names
    end
    
    # Returns the number of tuples in the relation variable
    def tuple_count
      underlying_table.count
    end
    
    # Yields the block with each tuple inside the relvar
    def each
      return unless block_given?
      underlying_table.each{|t| yield(@tuple.send(:__set_physical,t))}
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
    
    # Returns a tuple by its primary key value
    def restrict(*args, &block)
      DerivedRelvar.new(@db, relvar_def, underlying_table.filter(*args, &block))
    end
    
    # Returns the single tuple from this relvar. Raises an IllegalStateError
    # if there is more than one tuple in the relvar.
    def tuple_extract
      raise IllegalStateError, "Tuple extract must be invoked on relations of cardinality 1"\
        unless tuple_count == 1
      each{|t| return t}    
    end
    
  end # module CommonRelvarMethods
    
  # Relation variable inside a database
  class Relvar
    include CommonRelvarMethods
    
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
    
    # Affects a value to this relation variable
    def affect(value)
      case value
        when Array
          underlying_table.delete
          self << value
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
          tuples.each{|t| self.<<(t)} 
        when Hash
          underlying_table.insert(relvar_def.__to_physical_tuple(self, tuples))
        else
          raise ArgumentError, "Unable to insert #{tuples} inside a relation variable"
      end
    end
    
    # Returns the underlying table as a Sequel::Dataset object
    def underlying_table
      @underlying_table ||= db.handler[relvar_def.namespace_qualified_name(db.handler)]
    end
    
    private :underlying_table
  end # class Relvar
  
  # Derived relation variable
  class DerivedRelvar
    include CommonRelvarMethods
    
    # Underlying database
    attr_reader :db
    
    # Relation variable heading
    attr_reader :relvar_def
    
    # Underlying sequel table
    attr_reader :underlying_table
    
    # Creates a derived relvar instance
    def initialize(db, relvar_def, underlying_table)
      @db, @relvar_def, @underlying_table = db, relvar_def, underlying_table
      @tuple = Tuple.new(relvar_def)
    end
    
  end # class DerivedRelvar
end # module Rubyrel