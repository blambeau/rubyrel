module Rubyrel
  module Commands
    class Create < Rubyrel::Commands::Command
      
      # Contribute to options
      def add_options(opt)
      end
      
      # Returns the command banner
      def banner
        "Creates a relation database using a schema passed as first argument.\n"\
        "Physical handler may be specified through options."
      end
      
      # Checks that the command may be safely executed!
      def check_command_policy
        true
      end
      
      # Creates a Sequel database instance for a given schema
      def create_database(schema)
        self.handler_uri = "sqlite://#{schema.name}.db" unless handler_uri
        info("Using #{handler_uri} as physical handler") if verbose
        ::Sequel.connect(handler_uri)
      end
      
      # Runs the sub-class defined command
      def __run(requester_file, arguments)
        exit("Missing schema file argument", true) unless arguments.size == 1
        unless File.exists?(schema_file = arguments.shift)
          exit("Unable to find #{schema_file}")  
        end
        schema = Rubyrel::parse_ddl_file(schema_file)
        schema = Rubyrel::extend_schema(schema, Rubyrel::RUBYREL_CATALOG_FILE)
        # schema.all_objects_in_order.each{|o| puts o}
        db = schema.install_on!(create_database(schema), {:verbose => verbose})
        db = Rubyrel::Database.new(schema, db)
        schema.__save_on_database(db)
      end

    end # class Check
  end # module Commands
end # module Rubyrel
