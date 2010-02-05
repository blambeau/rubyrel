module Rubyrel
  module DDL
    class Schema
      
      # Installs this schema on a given sequel database
      def install_on(db)
        namespaces.values.each{|n| n.install_on(db)}
      end
      
      # Installs this schema on a given sequel database
      def uninstall_on(db)
        namespaces.values.each{|n| n.uninstall_on(db)}
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