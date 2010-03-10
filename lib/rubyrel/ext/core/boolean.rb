class Boolean
  
  # Converts a ruby value to a value that can be inserted as a column value
  # inside a sequel table
  def self.__rubyrel_to_physical_value(ruby_value)
    return ruby_value if ruby_value==true or ruby_value==false
    raise Rubyrel::PhysicalRepresentationError, "Unable to convert #{ruby_value} to a Boolean physical/sql value"
  end
  
  # Converts a physical value to a logical/ruby one
  def self.__rubyrel_from_physical_value(physical_value)
    return physical_value if physical_value==true or physical_value==false
    case physical_value
      when 0, '0', 'false', 'f'
        false
      when 1, '1', 'true', 't'
        true
      else
        raise Rubyrel::PhysicalRepresentationError, "Unable to convert #{physical_value} to a logical/ruby value"
    end
  end
  
end # class Boolean
