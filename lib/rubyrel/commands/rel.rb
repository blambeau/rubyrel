module Rubyrel
  module Commands
    class Rel < Rubyrel::Commands::Command

      # Interprets Rel commands
      class Interpretor
        
        # Rubyrel database
        attr_reader :db
        
        # Creates an interpretor instance
        def initialize(db)
          @db = db
        end
        
        # Starts interpretation of commands
        def execute
          while cmd = gets.strip
            case cmd
              when '\q'
                return
              when /^([a-z_]+)$/
                relvar = $1.to_sym
                if db.respond_to?(:default) and db.default.respond_to?(relvar)
                  puts db.default.send(relvar).to_tutorial_d
                else
                  puts "Unknown relvar #{relvar}"
                end
              when /^([a-z_]+)\.([a-z_]+)$/
                namespace, relvar = $1.to_sym, $2.to_sym
                if db.respond_to?(namespace)
                  namespace = db.send($1.to_sym)
                  if namespace.respond_to?(relvar)
                    relvar = namespace.send(relvar)
                    puts relvar.to_tutorial_d
                  else
                    puts "Unknown relvar #{relvar}"
                  end
                else
                  puts "Unknown namespace #{namespace}"
                end
            end
          end
        end
        
      end # class Interpretor

      # File to execute on the engine  
      attr_accessor :file_execution
        
      # Contribute to options
      def add_options(opt)
        opt.on("--file=FILE", "-f", "Executes a given file on the database") do |value|
          self.file_execution = value
        end
      end
      
      # Returns the command banner
      def banner
        "Launches the rel command line tool"
      end
      
      # Checks that the command may be safely executed!
      def check_command_policy
        true
      end
      
      # Runs the sub-class defined command
      def __run(requester_file, arguments)
        sequel_db = connect_database
        schema = Rubyrel::DDL::Schema.new(:noname)
        schema.__load_from_database(sequel_db)
        rubyrel_db = Rubyrel::Database.new(schema, sequel_db)
        if file_execution
          rubyrel_db.instance_eval(File.read(file_execution))
        else
          Interpretor.new(rubyrel_db).execute
        end
      end

    end # class Check
  end # module Commands
end # module Rubyrel
