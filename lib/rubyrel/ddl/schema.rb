module Rubyrel
  module DDL
    # Database schema definition
    class Schema
      include Enumerable
      
      # Schema name
      attr_reader :name
      
      # Schema namespaces (names => Namespace instances)
      attr_reader :namespaces
      
      # Creates a schema with a name
      def initialize(name)
        @name = name
        @namespaces = {}
      end
      
      # Executes a DSL value on this schema
      def __dsl_execute(file = nil, &block)
        DSL.new(self, file, &block)
      end

      # Saves this schema inside a relational database      
      def __save_on_database(db)
        db.transaction{|t| 
          all_objects_in_order.each {|obj|
            obj.__save_on_database(db, t)
          }
        }
      end
      
      # Loads this schema from a relational database
      def __load_from_database(db)
        db[Rubyrel::DDL::Naming::relvar_qualified_name(db, :rubyrel_catalog, :namespaces)].each do |t|
          namespace(t[:name].to_sym, true)
        end
        each_namespace{|n| n.__load_from_database(db)}
      end
      
      # Yields the block with each namespace
      def each
        namespaces.each_pair{|name, n| yield n if block_given?}
      end
      alias :each_namespace :each
      
      # Returns a namespace by its name, creating an empty one if requested.
      def namespace(name, create_empty = true)
        namespaces[name] = Namespace.new(self, name) if not(namespaces.has_key?(name)) and create_empty
        namespaces[name]
      end
      
      # Adds a namespace to this schema
      def add_namespace(namespace) 
        @namespaces[namespace.name] = namespace
      end
      
      # Returns all objects in the schema
      def all_objects
        objects = []
        each_namespace{|n| objects << n}
        each_namespace{|n| 
          n.each_relvar{|r| objects << r}
        }
        each_namespace{|n| 
          n.each_relvar{|r| r.each_candidate_key{|k| objects << k}}
        }
        each_namespace{|n| 
          n.each_relvar{|r| r.each_foreign_key{|k| objects << k}}
        }
        objects
      end
      
      # Returns an array of all basic objects, in dependency order
      def all_objects_in_order
        all_objects
      end
      
    end # class Schema
  end # module DDL
end # module Rubyrel