class Boolean
  
  # Checks if a given value is belongs to the domain.
  def rel_belongs?(value)
    (true == value) || (false == value)
  end
  
end