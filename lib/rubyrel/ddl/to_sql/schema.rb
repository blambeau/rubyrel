module Rubyrel
  module DDL
    class Schema
      
      # Executes some DDL statements
      def execute_ddl(db, ddl, options = {})
        return if ddl.empty?
        puts("Executing: " + ddl) if options[:verbose]
        db.execute_ddl(ddl)
      end
      
      # Installs this schema on a given sequel database. Returns the database
      # instance.
      def install_on(db, options = {})
        execute_ddl(db, 'BEGIN', options)
        all_objects_in_order.each{|o| 
          sql = o.to_create_sql(db)
          execute_ddl(db, sql, options) unless sql.nil? or sql.empty?
        }
        execute_ddl(db, 'COMMIT', options)
        db
      end
      
      # Forces a re-installation a given database. Returns the database
      # instance.
      def install_on!(db, options = {})
        uninstall_on!(db, options)
        install_on(db, options)
        db
      end
      
      # Installs this schema on a given sequel database. Returns the database
      # instance.
      def uninstall_on(db, options = {})
        buffer, sql = "", ""
        all_objects_in_order.reverse.each{|o| 
          sql = o.to_clean_sql(db)
          (buffer << sql << ";\n") unless sql.nil? or sql.empty?
        }
        execute_ddl(db, buffer, options)
        db
      end
      
      # Forces an installation. Returns the database
      # instance.
      def uninstall_on!(db, options = {})
        sql = ""
        all_objects_in_order.reverse.each{|o| 
          begin
            sql = o.to_clean_sql(db)
            execute_ddl(db, sql, options)
          rescue Sequel::Error => ex
            puts "Ignoring: #{ex.message}" if options[:verbose]
          end
        }
        db
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