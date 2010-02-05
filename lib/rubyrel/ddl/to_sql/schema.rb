module Rubyrel
  module DDL
    class Schema
      
      # Returns a SQL script for creating the whole schema inside a database
      def to_create_sql(db)
        buffer = ""
        buffer << to_create_database_sql(db) << ";\n"
        namespaces.values.each{|n| buffer << n.to_create_sql(db) << "\n"}
        buffer
      end
      
      # Returns a SQL script for cleaning the whole schema inside a database
      def to_clean_sql(db)
        buffer = ""
        buffer << to_drop_database_sql(db) << ";\n"
        buffer
      end
      
      # Generates a SQL DDL statement for creating the database, using
      # a Sequel Database object as dialect helper
      def to_create_database_sql(db)
        db.send(:create_database_sql, self.name, {})
      end
      
      # Generates a SQL DDL statement for dropping the database, using
      # a Sequel Database object as dialect helper
      def to_drop_database_sql(db)
        db.send(:drop_database_sql, self.name, {})
      end
      
    end # class Schema
  end # module DDL
end # module Rubyrel