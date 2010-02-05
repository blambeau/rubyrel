module Sequel
  class Database
    
    # DDL statement for creating a schema
    def create_schema_sql(name)
      "CREATE SCHEMA #{quote_identifier(name)}"
    end
    
    # DDL statement for dropping a schema
    def drop_schema_sql(name)
      "DROP SCHEMA #{quote_identifier(name)}"
    end
    
    private :create_schema_sql, :drop_schema_sql
  end
end