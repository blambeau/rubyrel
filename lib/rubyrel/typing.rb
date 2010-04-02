require 'rubyrel/typing/domain'
require 'rubyrel/typing/core'
require 'rubyrel/typing/relational'
require 'rubyrel/typing/additional'
module Rubyrel
  module Typing
  
    # Generates a new domain on the fly by extension of an existing domain
    # and including a set fof modules  
    def generate(superclass, class_modules, instance_modules)
      clazz = superclass.nil? ? Class.new : Class.new(superclass)
      clazz.instance_eval{
        include ::Rubyrel::Typing::Domain
        class_modules.each{|mod| extend mod} if class_modules
        instance_modules.each{|mod| include mod} if instance_modules
      }
      clazz
    end
    module_function :generate
    
    # Creates a heading instance
    def heading(pairs)
      case pairs
        when Heading
          pairs
        when Hash  
          ::Rubyrel::Typing::Heading.new(pairs)
        else
          raise ArgumentError, "Unable to convert #{pairs} to a tuple type"
      end
    end
    module_function :heading
    
    # Creates a tuple type instance
    def tuple_domain(h)
      clazz = generate(nil, [TupleDomain], [TupleValue])
      clazz.instance_eval{ @heading = ::Rubyrel::Typing::heading(h) }
      clazz
    end
    module_function :tuple_domain
    
    # Creates a domain by restriction of another one
    def constrained(base, &block)
      clazz = generate(base, [ConstrainedDomain], nil)
      clazz.__rubyrel_add_domain_constraint(&block)
      clazz.instance_eval { private_class_method :new if method_defined?(:new)}
      clazz
    end
    module_function :constrained
    
  end # module Typing
end # module Rubyrel
