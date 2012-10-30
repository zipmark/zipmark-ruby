module Zipmark
  class Client
    attr_accessor :application_id, :application_secret, :adapter, :resources

    def initialize(application_id, application_secret, adapter = Zipmark::Adapters::HTTPartyAdapter.new)
      @adapter = adapter
      adapter.username = application_id
      adapter.password = application_secret
      self.resources = load_resources
    end

    def load_resources
      hash = {}
      adapter.get("/")["vendor_root"]["links"].each {|link| hash[link["rel"]] = Resource.new({ :client => self }.merge(link)) }
      hash
    end

    def get(path)
      adapter.get(path)
    end

    def post(path, body)
      adapter.post(path, body)
    end

    def method_missing(meth, *args, &block)
      resources[meth.to_s] || raise(NoMethodError, "No resource or method: '#{meth}'")
    end
  end
end
