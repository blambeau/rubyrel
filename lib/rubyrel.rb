require 'rubygems'
require 'sequel'
require 'rubyrel/ext'
require 'rubyrel/ddl'
module Rubyrel
  
  # Current Rubyrel version
  VERSION = "0.0.1".freeze
  
  # Regular expression for checking all named things
  NAMED_REGEX = /^[a-z][a-z0-9_]*$/
  
  # Regular expression for checking all named things
  QUALIFIED_NAMED_REGEX = /^([a-z][a-z0-9_]*)\.([a-z][a-z0-9_]*)$/
  
  # Parses a DDL string
  def parse_ddl(str)
    Rubyrel::DDL.instance_eval(str)
  end
  module_function :parse_ddl
  
  # Parses a DDL file
  def parse_ddl_file(file)
    parse_ddl(File.read(file))
  end
  module_function :parse_ddl_file
  
end