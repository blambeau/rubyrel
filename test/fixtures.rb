module Rubyrel
  module Fixtures
    
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
    
  end # module Fixtures
end # module Rubyrel