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
    # options - Hash options used to configure the Client (default: {})
    # application_id - The Identifier for your application
    # application_secret - The Secret for your Application
    #      :adapter - The Instance of an Adapter that wraps your preferred HTTP Client
    #      :production - The Boolean determining if Production Mode is enabled
    def initialize(options = {})
      @adapter = options[:adapter] || Zipmark::Adapters::HTTPClientAdapter.new
      adapter.production = options[:production]
      adapter.username = options[:application_id]
      adapter.password = options[:application_secret]
      @identifier = options[:vendor_identifier]
      @resources = load_resources
    end

    def identifier
      @identifier
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

    # Public: Check for an ok response code (200-299)
    #
    # response - A response object specific to the adapter
    def successful?(response)
      adapter.successful?(response)
    end

    # Public: Check for a validation error response (422)
    #
    # response - A response object specific to the adapter
    def validation_error?(response)
      adapter.validation_error?(response)
    end

    def build_callback(request)
      Zipmark::Callback.new(request, :client => self)
    end

    def method_missing(meth, *args, &block)
      @resources[meth.to_s] || raise(NoMethodError, "No resource or method: '#{meth}'")
    end

    private
    def load_resources
      hash = {}
      response = get("/")
      object = JSON.parse(response.body)
      if successful?(response)
        object["vendor_root"]["links"].each {|link| hash[link["rel"]] = Resource.new({ :client => self }.merge(link)) }
      else
        raise Zipmark::Error.new(object)
      end
      hash
    end
  end
end
