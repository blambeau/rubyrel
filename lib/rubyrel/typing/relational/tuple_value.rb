module Rubyrel
  module Typing
    module TupleValue
      
      # Creates a tuple value instance
      def initialize(physical)
        @physical = physical
        self.class.heading.each do |attribute|
          (class << self; self; end).send(:define_method, attribute.name){
            @physical[attribute.name]
          }
        end
      end
      
    end # module TupleValue
  end # module Typing
end # module Rubyrel