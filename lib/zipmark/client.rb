module Zipmark
  # Public: The Zipmark API Client.
  #
  # Examples
  #
  #   client = Zipmark::Client.new("app-id", "app-secret", :production => false)
  #   client.get("/")
  #
  class Client
    # Public: Gets the Adapter.
    attr_reader :adapter

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
      @resources = load_resources
    end


    # Public: Send a GET Request to the given API Path
    #
    # path - A String which can be a relative path to the API root, or a full URL
    def get(path)
      adapter.get(path)
    end

    # Public: Send a POST Request to the given API Path
    #
    #  path - A String which can be a relative path to the API root, or a full URL
    #  body - A Object which responds to to_json and represents the body of the POST
    def post(path, body)
      adapter.post(path, body)
    end

    # Public: Send a PUT Request to the given API Path
    #
    #  path - A String which can be a relative path to the API root, or a full URL
    #  body - A Object which responds to to_json and represents the body of the PUT
    def put(path, body)
      adapter.put(path, body)
    end

    # Public: Send a DELETE Request to the given API Path
    #
    # path - A String which can be a relative path to the API root, or a full URL
    def delete(path)
      adapter.delete(path)
    end

    def method_missing(meth, *args, &block)
      @resources[meth.to_s] || raise(NoMethodError, "No resource or method: '#{meth}'")
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
