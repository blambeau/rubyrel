module Rubyrel
  module DDL
    module Naming
      
      # Checks if the namespace may be forgotten or not
      def forget_namespace?(db, namespace_name) 
        (namespace_name == :default || db.default_schema.to_s == namespace_name.to_s)
      end
      module_function :forget_namespace?
      
      # Converts a relvar name to a relvar name qualified by
      # its namespace, acording to abilities of a Sequel Database
      # instance.
      def relvar_qualified_name(db, namespace_name, relvar_name)
        return relvar_name if forget_namespace?(db, namespace_name)
        db.supports_schemas? ? "#{namespace_name}__#{relvar_name}".to_sym :
                               "#{namespace_name}$$#{relvar_name}".to_sym
      end
      module_function :relvar_qualified_name

    end # module Naming
  end # module DDL
end # module Rubyrel