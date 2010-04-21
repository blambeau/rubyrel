class Module

  # Converts a ruby value to a value that can be inserted as a column value
  # inside a sequel table
  def self.__rubyrel_to_physical_value(ruby_value)
    return ruby_value.name.to_s if Module===ruby_value
    raise Rubyrel::PhysicalRepresentationError, "Unable to convert #{ruby_value}:#{ruby_value.class.name} to a Module physical/sql value"
  end
  
  # Converts a physical value to a logical/ruby one
  def self.__rubyrel_from_physical_value(physical_value)
    Kernel.eval(physical_value.to_s)
  rescue => ex
    raise ArgumentError, "Unable to convert #{physical_value.to_s} to a Module logical value:\n#{ex.message}", ex.backtrace
  end

end