module Rubyrel
  module Defaults
    module Facade
      
      # Factors an autonumber default handler
      def autonumber
        Autonumber.new
      end
      
      # Factors a now default handler
      def now
        Now.new
      end
      
    end # module Facade
  end # module Defaults
end # module Rubyrel