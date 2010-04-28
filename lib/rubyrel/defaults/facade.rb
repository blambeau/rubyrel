module Rubyrel
  module Defaults
    module Facade
      
      # Factors an autonumber default handler
      def autonumber(*args)
        Autonumber.new(*args)
      end
      
      # Factors a now default handler
      def now(*args)
        Now.new(*args)
      end
      
    end # module Facade
  end # module Defaults
end # module Rubyrel