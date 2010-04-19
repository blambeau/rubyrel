module Rubyrel
  module Defaults
    class Autonumber < DefaultHandler

      # Computes the default value
      def compute_value(relvar, attribute_def, tuple)
        max = relvar.send(:underlying_table).max(attribute_def.name)
        if max.nil?
          1
        elsif max.respond_to?(:succ)
          max.succ
        elsif max.respond_to?(:next)
          max.next
        else
          max + 1
        end
      end
      
    end # class Autonumber
  end # module Defaults
end # module Rubyrel