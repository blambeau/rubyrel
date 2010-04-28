module Rubyrel
  module Defaults
    class Autonumber < DefaultHandler

      # Creates an autonumber instance
      def initialize(*args)
        @relative_to = args.empty? ? nil : args
      end

      # Computes the default value
      def compute_value(relvar, attribute_def, tuple)
        ut = relvar.send(:underlying_table)
        if @relative_to
          filter = {}
          @relative_to.each{|r| filter[r] = tuple[r]}
          ut = ut.filter(filter)
        end
        max = ut.max(attribute_def.name)
        if max.nil?
          1
        else
          max = max.to_i if Integer == attribute_def.domain 
          if max.respond_to?(:succ)
            max.succ
          elsif max.respond_to?(:next)
            max.next
          else
            max + 1
          end
        end
      end
      
    end # class Autonumber
  end # module Defaults
end # module Rubyrel