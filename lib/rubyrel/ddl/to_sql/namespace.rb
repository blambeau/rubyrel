module Rubyrel
  module DDL
    class Namespace
      
      # Returns a SQL script for creating the whole schema inside a database
      def to_create_sql(db)
        buffer = ""
        buffer << to_sql_create_namespace(db) << ";\n"
        relvars.values.each{|n| buffer << n.to_create_sql(db) << ";\n"}
        buffer
      end
      
      # Returns a SQL script for cleaning the whole schema inside a database
      def to_clean_sql(db)
        buffer = ""
        buffer << to_sql_drop_namespace(db) << ";\n"
        buffer
      end
      
      # Generates a SQL DDL create namespace using a Sequel Database object
      # as dialect helper
      def to_sql_create_namespace(db)
        db.send(:create_schema_sql, self.name, {})
      end
      
      # Generates a SQL DDL drop namespace using a Sequel Database object
      # as dialect helper
      def to_sql_drop_namespace(db)
        db.send(:drop_schema_sql, self.name, {})
      end
      
    end # class Namespace
  end # module DDL
end # module Rubyrel