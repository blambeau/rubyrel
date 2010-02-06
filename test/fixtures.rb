module Rubyrel
  module Fixtures
    
    def pgsql_test_connection_info
      {:host     => 'localhost',
       :port     => 5432,
       :database => 'rubyrel_test',
       :user     => 'rubyrel',
       :password => 'rubyrel',
       :encoding => 'utf8'}
    end
    
    def pgsql_test_database
      ::Sequel.postgres(pgsql_test_connection_info)
    end
    
    def sqlite_test_database
      here = File.join(File.dirname(__FILE__))
      ::Sequel.connect("sqlite://rubyrel.db")
    end
    
    # Yields the block with all sequel database that are known
    def all_sequel_databases
      yield pgsql_test_database
      yield sqlite_test_database
    end
    
    # Returns the fixtures folder
    def fixtures_folder
      File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))
    end
    
    # Returns an array with all .rrel fixture files
    def rrel_files
      Dir[File.join(fixtures_folder, '**', '*.rrel')]
    end
    
    # Finds a .rrel schema file by name
    def rrel_file(name)
      name = "#{name}.rrel" unless name =~ /\.rrel$/
      rrel_files.find{|f| File.basename(f) == name}
    end
    
    # Returns an array containing all .rrel files contained
    # under the fixtures folder. If a block is given yields
    # it with each file in turn
    def all_rrel_files
      files = rrel_files.collect{|f| File.expand_path(f)}
      files.each{|f| yield(f)} if block_given?
      files
    end
    
    # Decodes a .rrel file whose name is provided
    def rrel_schema(name)
      Rubyrel.parse_ddl_file(rrel_file(name))
    end
    
    # Yields the block with all fixture schemas
    def all_schema
      all_rrel_files{|f| yield Rubyrel.parse_ddl_file(f)}
    end
    
    # Creates a Rubyrel database instance
    def database(schema, handler)
      ::Rubyrel::Database.new(schema, handler)
    end
    
  end # module Fixtures
end # module Rubyrel