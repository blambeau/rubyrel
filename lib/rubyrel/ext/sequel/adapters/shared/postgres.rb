module Sequel
  module Postgres
    module DatabaseMethods
      
      # Returns true if the database supports schemas, false otherwise
      def supports_schemas?
        true
      end
    
      # DDL statement for creating a schema
      def create_schema_sql(name, opts = {})
        "CREATE SCHEMA #{quote_identifier(name)}"
      end
    
      # DDL statement for creating a schema
      def drop_schema_sql(name, opts = {})
        "DROP SCHEMA #{quote_identifier(name)} CASCADE"
      end
    
    end
  end
end