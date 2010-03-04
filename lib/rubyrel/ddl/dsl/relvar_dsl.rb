module Rubyrel
  module DDL
    # Definition of a relation variable
    class Relvar
      
      # The domain specific language for relation variables
      class DSL
        include DSLCommons
        
        # Creates a DSL instance for a given relvar and executes the block
        # inside its context
        def initialize(relvar, &block)
          @relvar = relvar
          self.instance_eval(&block) if block
        end
        
        # Returns the main object populated by this DSL
        def __main_object
          @relvar
        end
        
        # Returns the current schema under construction
        def __schema
          @relvar.namespace.schema
        end
      
        # Finds a relvar by name
        def relvar(name)
          r = @relvar.namespace.relvar(name, false)
          raise "Unknown relvar #{name}" unless r
          r
        end
      
        # Adds some attribute(s) to the relation variable
        def attribute(name, domain, options = {})
          raise "Invalid attribute definition #{name}" unless Symbol===name and Class===domain
          @relvar.add_attribute(name, domain, options)
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
            
    end # class Relvar
  end # module DDL
end # module Rubyrel