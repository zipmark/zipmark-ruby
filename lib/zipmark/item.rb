module Zipmark
  class Item
    attr_accessor :options

    def initialize(options={})
      @options = Util.stringify_keys(options)
    end
  end
end
