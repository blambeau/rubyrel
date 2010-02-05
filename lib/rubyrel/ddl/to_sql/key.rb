module Rubyrel
  module DDL
    class Key
      
      # Generates a SQL DDL statement for creating the key, using
      # a Sequel Database object as dialect helper
      def to_add_constraint_sql(db)
        if db.supports_external_add_constraints?
          gen = ::Sequel::Schema::AlterTableGenerator.new(db)
          columns = attributes.collect{|a| a.name}
          type = primary? ? :primary_key : :unique
          gen.rubyrel_add_operation(:op => :add_constraint, :type => type,  
                                    :name => name, :columns => columns)
          db.send(:alter_table_sql_list, relvar.namespace_qualified_name(db), gen.operations)[0]
        else
          ""
        end
      end
      alias :to_create_sql :to_add_constraint_sql
      
      # Generates a SQL DDL statement for droping the key, using
      # a Sequel Database object as dialect helper
      def to_drop_constraint_sql(db)
        if db.supports_external_drop_constraints?
          gen = ::Sequel::Schema::AlterTableGenerator.new(db)
          gen.drop_constraint(self.name)
          db.send(:alter_table_sql_list, relvar.namespace_qualified_name(db), gen.operations)[0]
        else
          ""
        end
      end
      alias :to_clean_sql :to_drop_constraint_sql
      
    end # class Key
  end # module DDL
end # module Rubyrel
