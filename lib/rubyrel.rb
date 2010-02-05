require 'rubyrel/ddl'
module Rubyrel
  
  # Current Rubyrel version
  VERSION = "0.0.1".freeze
  
  # Regular expression for checking all named things
  NAMED_REGEX = /^[a-z][a-z0-9_]*$/
  
  # Regular expression for checking all named things
  QUALIFIED_NAMED_REGEX = /^([a-z][a-z0-9_]*)\.([a-z][a-z0-9_]*)$/
  
end