module Rubyrel
  module DDL
    class Namespace
      
      # Generates a SQL DDL create namespace using a Sequel Database object
      # as dialect helper
      def to_sql_create_namespace(db)
        if db.supports_schemas?
          db.send(:create_schema_sql, self.name, {})
        else
          ""
        end
      end
      alias :to_create_sql :to_sql_create_namespace
      
      # Generates a SQL DDL drop namespace using a Sequel Database object
      # as dialect helper
      def to_sql_drop_namespace(db)
        if db.supports_schemas?
          db.send(:drop_schema_sql, self.name, {})
        else
          ""
        end
      end
      alias :to_clean_sql :to_sql_drop_namespace
      
    end # class Namespace
  end # module DDL
end # module Rubyrel