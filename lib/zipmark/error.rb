module Zipmark
  class Error < StandardError
    attr_accessor :classification, :messages, :code
  end
end
