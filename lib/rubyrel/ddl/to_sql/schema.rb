module Rubyrel
  module DDL
    class Schema
      
      # Installs this schema on a given sequel database
      def install_on(db)
        buffer = ""
        all_objects_in_order.each{|o| 
          sql = o.to_create_sql(db)
          (buffer << sql << ";\n") unless sql.nil? or sql.empty?
        }
        #puts buffer
        db.execute_ddl(buffer)
      end
      
      # Installs this schema on a given sequel database
      def uninstall_on(db)
        buffer = ""
        all_objects_in_order.reverse.each{|o| 
          sql = o.to_clean_sql(db)
          (buffer << sql << ";\n") unless sql.nil? or sql.empty?
        }
        #puts buffer
        db.execute_ddl(buffer)
      end
      
      # Generates a SQL DDL statement for creating the database, using
      # a Sequel Database object as dialect helper
      def to_create_database_sql(db)
        db.send(:create_database_sql, self.name, {})
      end
      alias :to_create_sql :to_create_database_sql
      
      # Generates a SQL DDL statement for dropping the database, using
      # a Sequel Database object as dialect helper
      def to_drop_database_sql(db)
        db.send(:drop_database_sql, self.name, {})
      end
      alias :to_clean_sql :to_drop_database_sql
      
    end # class Schema
  end # module DDL
end # module Rubyrel