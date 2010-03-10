require 'base64'
class Class
  
  # Converts a ruby value to a value that can be inserted as a column value
  # inside a sequel table
  def __rubyrel_to_physical_value(ruby_value)
    return ruby_value if Sequel::Schema::Generator::GENERIC_TYPES.include?(self)
    Base64.encode64(Marshal.dump(ruby_value))
  rescue TypeError => ex
    raise Rubyrel::PhysicalRepresentationError, "Unable to convert #{ruby_value} to a physical SQL value"
  end
  
  # Converts a physical value to a logical/ruby one
  def __rubyrel_from_physical_value(physical_value)
    return physical_value if Sequel::Schema::Generator::GENERIC_TYPES.include?(self)
    Marshal.load(Base64.decode64(physical_value))
  end
  
end