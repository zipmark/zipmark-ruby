module Zipmark
  class Entity
    attr_accessor :options

    def initialize(options={})
      @options = Util.stringify_keys(options)
    end

    def method_missing(meth, *args, &block)
      options[meth.to_s] || raise(NoMethodError, "No attribute or method: '#{meth}'")
    end
  end
end
