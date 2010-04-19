module Rubyrel
  module Defaults
    class Now < DefaultHandler
      
      # Computes the default value
      def compute_value(relvar, attribute_def, tuple)
        Time.now
      end
      
    end # class Now 
  end # module Defaults
end # module Rubyrel