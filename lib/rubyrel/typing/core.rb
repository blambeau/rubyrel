require "rubyrel/typing/core/builtin_domain"
require "rubyrel/typing/core/boolean"
[String, Integer, Float, Time].each do |clazz|
  clazz.instance_eval{ extend ::Rubyrel::Typing::BuiltinDomain }
end
