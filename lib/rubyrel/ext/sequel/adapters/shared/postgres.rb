module Sequel
  module Postgres
    module DatabaseMethods
      
      # Returns true if the database supports schemas, false otherwise
      def supports_schemas?
        true
      end
    
      # DDL statement for creating a schema
      def create_schema_sql(name)
        "CREATE NAMESPACE #{quote_identifier(name)}"
      end
    
      # DDL statement for creating a schema
      def drop_schema_sql(name)
        "DROP NAMESPACE #{quote_identifier(name)}"
      end
    
    end
  end
end