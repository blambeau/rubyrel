class Boolean
  extend ::Rubyrel::Typing::BuiltinDomain
  
  # Checks if a given value is belongs to the domain.
  def __rubyrel_belongs?(value)
    (true == value) || (false == value)
  end
  
end