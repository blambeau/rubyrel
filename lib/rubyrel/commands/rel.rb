module Rubyrel
  module Commands
    class Rel < Rubyrel::Commands::Command

      # Contribute to options
      def add_options(opt)
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
      end

    end # class Check
  end # module Commands
end # module Rubyrel
