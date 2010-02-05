module Sequel
  class Database
    
    # Returns true if the database supports schemas, false otherwise
    def supports_schemas?() false; end
    
    # Returns true if the database supports adding constraints with alter table
    # DDL statements, false otherwise
    def supports_external_add_constraints?() false; end
    
    # Returns true if the database supports removing constraints with alter table
    # DDL statements, false otherwise
    def supports_external_drop_constraints?() false; end
    
  end # class Database
end # module Sequel