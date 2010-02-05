module Sequel
  class Database
    
    # Returns true if the database supports schemas, false otherwise
    def supports_schemas?
      false
    end
    
  end # class Database
end # module Sequel