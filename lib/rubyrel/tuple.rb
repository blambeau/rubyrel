module Rubyrel
  # Tuple value
  class Tuple
    
    # Creates a tuple instance
    def initialize(relvar_def)
      @relvar_def = relvar_def
      populate!
    end
    
    # Decorates this class with attributes reader for attributes
    def populate!
      @relvar_def.each_attribute{|a|
        self.instance_eval <<-EOF
          def #{a.name.to_s}
            @physical && @physical[:#{a.name.to_s}]
          end
        EOF
      }
    end
    
    # Sets the physical representation
    def __set_physical(physical)
      @physical = @relvar_def.__to_logical_tuple(physical)
      self
    end
    
    # Returns a value by its name
    def [](name)
      @physical && @physical[name]
    end
    
    # Returns a Rel literal for this tuple
    def inspect
      @physical.inspect
    end
    
    # Returns this tuple as a Hash
    def to_h
      @physical.dup
    end
    
    # Converts this tuple to a tutorial D statement
    def to_tutorial_d(relvar_def)
      values = []
      @relvar_def.each_attribute{|a| values << "#{a.name} #{self.send(a.name).inspect}"}
      "TUPLE{#{values.join(', ')}}"
    end
    
    private :populate!, :__set_physical
  end # class Tuple
end # module Rubyrel