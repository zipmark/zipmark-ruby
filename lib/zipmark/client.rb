module Zipmark
  class Client
    attr_accessor :application_id, :application_secret, :adapter, :resources

    def initialize(application_id, application_secret, options = {})
      @adapter = options[:adapter] || Zipmark::Adapters::HTTPClientAdapter.new
      adapter.production = options[:production]
      adapter.username = application_id
      adapter.password = application_secret
      self.resources = load_resources
    end

    def load_resources
      hash = {}
      response = JSON.parse(get("/").body)
      response["vendor_root"]["links"].each {|link| hash[link["rel"]] = Resource.new({ :client => self }.merge(link)) }
      hash
    end

    def get(path)
      adapter.get(path)
    end

    def post(path, body)
      adapter.post(path, body)
    end

    def put(path, body)
      adapter.put(path, body)
    end

    def delete(path)
      adapter.delete(path)
    end

    def method_missing(meth, *args, &block)
      resources[meth.to_s] || raise(NoMethodError, "No resource or method: '#{meth}'")
    end
  end
end
