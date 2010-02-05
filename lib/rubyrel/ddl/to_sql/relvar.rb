module Rubyrel
  module DDL
    class Relvar
      
      # Checks if the namespace may be forgotten or not
      def forget_namespace?(db) 
        (namespace.name == :default || db.default_schema.to_s == namespace.name.to_s)
      end
      
      # Converts a relvar name to a relvar name qualified by
      # its namespace, acording to abilities of a Sequel Database
      # instance.
      def namespace_qualified_name(db)
        forget_namespace?(db) ? name : "#{namespace.name.to_s}__#{name.to_s}".to_sym
      end

      # Converts this relvar definition to a sequel schema generator instance
      # using a Sequel Database helper for SQL dialects.
      def to_sequel_schema_generator(db)
        require 'sequel'
        gen = ::Sequel::Schema::Generator.new(db)
        attributes.each_pair{|name, a| 
          gen.column(name, a.domain)
        }
        candidate_keys.each_pair{|name, k|
          next if primary_key==k
          gen.unique(k.attributes.collect{|a| a.name})
        }
        if pk = primary_key 
          columns = pk.attributes.collect{|a| a.name}
          gen.rubyrel_add_constraint(:type => :primary_key, 
                                     :name => pk.name,
                                     :columns => columns)
        end
        foreign_keys.each_pair{|name, fk|
          columns = fk.attributes.collect{|a| a.name}
          target_name = fk.target.relvar.namespace_qualified_name(db)
          target_columns = fk.target.attributes.collect{|a| a.name}
          gen.rubyrel_add_constraint(:type => :foreign_key, 
                                     :name => fk.name,
                                     :table => target_name,
                                     :key => target_columns)
        }
        gen
      end
      
      # Converts this relvar definition to a SQL create table statement using a Sequel 
      # Database object as dialect helper
      def to_sql_create_table(db)
        db.send(:create_table_sql, namespace_qualified_name(db), to_sequel_schema_generator(db), {})
      end
      
    end # class Relvar
  end # module DDL
end # module Rubyrel