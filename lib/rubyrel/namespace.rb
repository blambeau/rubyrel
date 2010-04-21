module Rubyrel
  # A database namespace
  class Namespace
    
    # The parent database
    attr_reader :db
    
    # The namespace DDL definition
    attr_reader :namespace_def
    
    # Relation variables under this namespace
    attr_reader :relvars
    
    # Creates a namespace instance
    def initialize(db, namespace_def)
      @db, @namespace_def = db, namespace_def
      populate!
    end
    
    # Populates this namespace
    def populate!
      @relvars = {}
      namespace_def.each_relvar{|r| 
        relvars[r.name] = Relvar.new(db, self, r)
        self.instance_eval <<-EOF
          def #{r.name}
            relvars[:#{r.name}]
          end
          def #{r.name}=(tuples)
            relvar(:#{r.name}).affect(tuples)
          end
        EOF
      }
    end
    
    # Returns a relation variable by its name. If raise_on_unfound is set to true, raise
    # an error if the relvar cannot be found. Returns nil otherwise.
    def relvar(name, raise_on_unfound = true)
      raise "Unknown relvar #{name}" unless relvars.has_key?(name) and raise_on_unfound
      relvars[name]
    end
    alias :[] :relvar
    
    private :populate!
  end #  class Namespace
end # module Rubyrel
