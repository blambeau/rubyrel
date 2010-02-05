module Rubyrel
  module DDL
    class Namespace
      
      # Installs this schema on a given sequel database
      def install_on(db)
        db.create_schema(self.name) if db.supports_schemas?
        relvars.values.each{|r| r.install_on(db)}
      end
      
      # Installs this schema on a given sequel database
      def uninstall_on(db)
        relvars.values.each{|r| r.uninstall_on(db)}
        db.drop_schema(self.name) if db.supports_schemas?
      end
      
      # Generates a SQL DDL create namespace using a Sequel Database object
      # as dialect helper
      def to_sql_create_namespace(db)
        db.send(:create_schema_sql, self.name, {})
      end
      alias :to_create_sql :to_sql_create_namespace
      
      # Generates a SQL DDL drop namespace using a Sequel Database object
      # as dialect helper
      def to_sql_drop_namespace(db)
        db.send(:drop_schema_sql, self.name, {})
      end
      alias :to_clean_sql :to_sql_drop_namespace
      
    end # class Namespace
  end # module DDL
end # module Rubyrel