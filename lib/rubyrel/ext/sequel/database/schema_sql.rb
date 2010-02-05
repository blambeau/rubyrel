module Sequel
  class Database
    private
    
    # DDL statement for creating a database
    def create_database_sql(name, opts = {})
      "CREATE DATABASE #{quote_identifier(name)}"
    end
    
    # DDL statement for dropping a database
    def drop_database_sql(name, opts = {})
      "DROP DATABASE #{quote_identifier(name)}"
    end
    
    # DDL statement for creating a schema
    def create_schema_sql(name, opts = {})
      "CREATE SCHEMA #{quote_identifier(name)}"
    end
    
    # DDL statement for dropping a schema
    def drop_schema_sql(name, opts = {})
      "DROP SCHEMA #{quote_identifier(name)}"
    end
    
  end
end