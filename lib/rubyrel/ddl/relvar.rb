module Rubyrel
  module DDL
    # Definition of a relation variable
    class Relvar
      
      # The domain specific language for relation variables
      class DSL
        
        # Creates a DSL instance for a given relvar and executes the block
        # inside its context
        def initialize(relvar, &block)
          @relvar = relvar
          self.instance_eval(&block) if block
        end
        
        # Adds some attribute(s) to the relation variable
        def attribute(mapping)
          mapping.each_pair{|name, type| @relvar.add_attribute(name, type)}
        end
        
        # Adds an candidate key on given attributes
        def candidate_key(*attributes)
          name = String===attributes[0] ? attributes.shift : "ak_#{@relvar.name}_#{@relvar.candidate_keys.size}"
          attributes = attributes.collect{|a| @relvar.attribute(a, true)}
          @relvar.add_candidate_key(name, attributes)
        end
        alias :alternate_key :candidate_key
        
        # Sets the primary key on given attributes
        def primary_key(*attributes)
          if attributes.size == 1 and String===attributes[0]
            @relvar.set_primary_key(@relvar.candidate_key(attributes[0], true))
          else
            name = String===attributes[0] ? attributes.shift : "pk_#{@relvar.name}"
            attributes.unshift(name)
            @relvar.set_primary_key(candidate_key(*attributes))
          end
        end
        
        # Adds a foreign key from some attributes to a key target
        def foreign_key(*args)
          # get the name
          name = String===args[0] ? args.shift : "fk_#{@relvar.name}_#{@relvar.foreign_keys.size}"
          
          # get the attribute => key mapping
          raise "Invalid foreign key definition #{args.inspect}" unless \
            args.size==1 and Hash===args[0] and \
            args[0].size == 1
          mapping = args[0]
          
          # get the attributes now
          attributes = args[0].keys.flatten.collect{|a| @relvar.attribute(a, true)}
          
          # get the target now
          target = mapping.values[0]
          target = target.primary_key if Relvar === target
          raise "Invalid foreign key target #{target}" unless Key===target
          @relvar.add_foreign_key(name, attributes, target)
        end
        
      end # class DSL
      
      # Parent namespace
      attr_reader :namespace
      
      # Relation variable name
      attr_reader :name
      
      # Relation primary key
      attr_reader :primary_key
      
      # Relation candidate keys
      attr_reader :candidate_keys
      
      # Relation foreign keys
      attr_reader :foreign_keys
      
      # Creates a relation variable inside a namespace
      def initialize(namespace, name)
        raise ArgumentError, "Invalid namespace #{namespace}" unless Namespace===namespace
        raise ArgumentError, "Invalid name #{name}" unless Symbol===name
        @namespace, @name = namespace, name
        @attributes  = {}
        @primary_key = nil
        @candidate_keys = {}
        @foreign_keys = {}
      end
      
      # Executes a DSL value on this namespace
      def __dsl_execute(&block)
        DSL.new(self, &block)
      end
      
      ############################################################### Query utilities
      
      # Returns an attribute by its name. If raise_if_unfound is set to true,
      # raises an error if the attribute cannot be found, returns nil otherwise 
      # in this case.
      def attribute(name, raise_if_unfound = false)
        return name if Attribute===name
        a = attributes[name]
        raise "No such attribute #{name}" if a.nil? and raise_if_unfound
        a
      end
      
      # Collects some attributes by their name
      def attributes(*names)
        return @attributes if names.empty?
        names.collect{|name| attribute(name, true)}
      end
      
      # Returns a candidate key by its name. If raise_if_unfound is set to true,
      # raises an error if the key cannot be found, returns nil otherwise 
      # in this case.
      def candidate_key(name, raise_if_unfound = false)
        return name if Key===name
        k = candidate_keys[name]
        raise "No such candidate key #{name}" if k.nil? and raise_if_unfound
        k
      end
      
      ############################################################### Modification utilities
      
      # Adds an attribute to the relation variable
      def add_attribute(name, domain)
        a = Attribute.new(self, name, domain)
        attributes[name] = a
      end
      
      # Adds a candidate key on some attributes
      def add_candidate_key(name, attributes)
        candidate_keys[name] = Key.new(self, name, attributes)
      end
      
      # Mark a given candidate key as being the primary key.
      def set_primary_key(key)
        @primary_key = key
      end
      
      # Adds a foreign key
      def add_foreign_key(name, attributes, target)
        foreign_keys[name] << ForeignKey.new(name, attributes, target)
      end
      
    end # class Relvar
  end # module DDL
end # module Rubyrel