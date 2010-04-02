module Rubyrel
  module Typing   
    module TupleGenerator
  
      # Factors a tuple type for a given heading
      def generate(heading)
        clazz = Class.new
        clazz.instance_eval{ @heading = heading }
        clazz.instance_eval{
          extend  TupleDomain
          include TupleValue
          private_class_method :new
        }
        clazz
      end
      module_function :generate
  
    end # module TupleGenerator
  end # module Typing
end # module Rubyrel