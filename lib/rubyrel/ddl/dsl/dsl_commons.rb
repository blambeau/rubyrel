module Rubyrel
  module DDL
    module DSLCommons
      
      # Lookup on namespaces 
      def method_missing(name, *args, &block)
        if __schema.namespaces.has_key?(name)
          __schema.namespaces[name]
        else
          super(name, *args, &block)
        end
      end
      
      # # Returns a relation variable by its name
      # def relvar(name)
      #   case main_object = __main_object
      #     when Namespace
      #       main_object.relvar(name, false)
      #     when Schema
      #       namespace, relvar = QUALIFIED_NAMED_REGEX.match(name.to_s)
      #       n = main_oject.namespace(namespace.to_sym, false)
      #       raise "No such namespace #{namespace}" unless n
      #       r= n.relvar(relvar, false)
      #       raise "No such relvar #{relvar}" unless r
      #       r
      #     when Relvar
      #       main_object.namespace.relvar(name)
      #   end
      # end

    end # module Commons
  end # module DDL
end # module Rubyrel