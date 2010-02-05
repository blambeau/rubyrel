module Rubyrel
  module DDL
    class Relvar
      
      # Checks if the namespace may be forgotten or not
      def forget_namespace?(db) 
        (namespace.name == :default || db.default_schema.to_s == namespace.name.to_s)
      end
      
      # Converts a relvar name to a relvar name qualified by
      # its namespace, acording to abilities of a Sequel Database
      # instance.
      def namespace_qualified_name(db)
        return name if forget_namespace?(db)
        result = "#{namespace.name.to_s}__#{self.name.to_s}"
        db.supports_schemas? ? result.to_sym : result
      end

      # Converts this relvar definition to a sequel schema generator instance
      # using a Sequel Database helper for SQL dialects.
      def to_sequel_schema_generator(db)
        gen = ::Sequel::Schema::Generator.new(db)
        attributes.each_pair{|name, a|  gen.column(name, a.domain) }
        gen
      end
      
      # Generates a SQL DDL create table statement using a Sequel Database 
      # object as dialect helper
      def to_sql_create_table(db)
        db.send(:create_table_sql, namespace_qualified_name(db), to_sequel_schema_generator(db), {})
      end
      alias :to_create_sql :to_sql_create_table
      
      # Generates a SQL DDL drop table statement using a Sequel Database 
      # object as dialect helper
      def to_sql_drop_table(db)
        db.send(:drop_table_sql, namespace_qualified_name(db))
      end
      alias :to_clean_sql :to_sql_drop_table
      
    end # class Relvar
  end # module DDL
end # module Rubyrel