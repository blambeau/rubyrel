module Sequel
  class Database
    
    # Creates a new schema with a given name
    def create_schema(name, opts = {})
      execute_ddl(create_schema_sql(name, opts))
    end
  
    # Creates a new schema with a given name
    def drop_schema(name, opts = {})
      execute_ddl(drop_schema_sql(name, opts))
    end
    
  end
end