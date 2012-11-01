module Zipmark
  # Public: The Zipmark API Client.
  #
  # Examples
  #
  #   client = Zipmark::Client.new("app-id", "app-secret", :production => false)
  #   client.get("/")
  class Client
    attr_accessor :application_id
    attr_accessor :application_secret
    attr_accessor :adapter
    attr_accessor :resources

    # Public: Initialize a Zipmark Client
    #
    # application_id - The Identifier for your application
    # application_secret - The Secret for your Application
    # options - Hash options used to configure the Client (default: {})
    #      :adapter - The Instance of an Adapter that wraps your preferred HTTP Client
    #      :production - The Boolean determining if Production Mode is enabled
    def initialize(application_id, application_secret, options = {})
      @adapter = options[:adapter] || Zipmark::Adapters::HTTPClientAdapter.new
      adapter.production = options[:production]
      adapter.username = application_id
      adapter.password = application_secret
      self.resources = load_resources
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

    private
    def load_resources
      hash = {}
      response = JSON.parse(get("/").body)
      response["vendor_root"]["links"].each {|link| hash[link["rel"]] = Resource.new({ :client => self }.merge(link)) }
      hash
    end
  end
end
