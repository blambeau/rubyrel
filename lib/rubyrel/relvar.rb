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
      db[relvar_def.namespace_qualified_name(db)].each{|t| yield(@tuple.__set_physical(t))}
    end
    
    # Inspects this relvar (returns a Rel code with the content of the relvar)
    def inspect
      ""
    end
    
  end # class Relvar
end # module Rubyrel