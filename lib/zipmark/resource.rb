module Zipmark
  class Resource
    attr_accessor :options

    def initialize(options={})
      @options = Util.stringify_keys(options)
    end

    def all
      @collection = Zipmark::Collection.new(self, Zipmark::Iterator)
    end

    def find
    end

    def href
      options["href"] || raise(Zipmark::ResourceError, "Resource did not specify href")
    end

    def rel
      options["rel"] || raise(Zipmark::ResourceError, "Resource did not specify rel")
    end

    def client
      options["client"] || raise(Zipmark::ClientError, "You must pass :client as an option")
    end
  end
end
