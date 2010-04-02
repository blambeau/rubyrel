require 'rubyrel/typing/domain'
require 'rubyrel/typing/core'
require 'rubyrel/typing/relational'
module Rubyrel
  module Typing
    
    # Creates a heading instance
    def heading(pairs)
      case pairs
        when Heading
          pairs
        when Hash  
          ::Rubyrel::Typing::Heading.new(pairs)
        else
          raise ArgumentError, "Unable to convert #{pairs} to a tuple type"
      end
    end
    module_function :heading
    
    # Creates a tuple type instance
    def tuple_type(heading)
      ::Rubyrel::Typing::TupleGenerator::generate(heading(heading))
    end
    module_function :tuple_type
    
  end # module Typing
end # module Rubyrel
