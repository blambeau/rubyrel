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
    
    # Recognizes the Boolean class
    def type_literal_generic_boolean(column)
      :boolean
    end
    
    # Recognizes the Symbol class
    def type_literal_generic_symbol(column)
      type_literal_generic_string(column)
    end
    
    # Recognizes the Module class
    def type_literal_generic_module(column)
      type_literal_generic_string(column)
    end
    
    # Recognizes the Object class
    def type_literal_generic_object(column)
      type_literal_generic_string(column)
    end
    
    # Recognizes the Object class
    def type_literal_generic_set(column)
      type_literal_generic_string(column)
    end
    
  end
end