module Rubyrel
  class Error < StandardError; end
  class PhysicalRepresentationError < Rubyrel::Error; end
  class TypeError < Rubyrel::Error; end
end