module Rubyrel
  module Commands
    class Check < Rubyrel::Commands::Command

      # Contribute to options
      def add_options(opt)
      end
      
      # Returns the command banner
      def banner
        "Checks a database relational schema passed as first argument"
      end
      
      # Checks that the command may be safely executed!
      def check_command_policy
        true
      end
      
      # Runs the sub-class defined command
      def __run(requester_file, arguments)
        exit("Missing schema file argument", true) unless arguments.size == 1
        unless File.exists?(schema_file = arguments.shift)
          exit("Unable to find #{schema_file}")  
        end
        Rubyrel::parse_ddl_file(schema_file)
      end

    end # class Check
  end # module Commands
end # module Rubyrel
