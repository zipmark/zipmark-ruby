module Zipmark
  class Entity
    attr_accessor :attributes, :client, :resource_type, :errors

    def initialize(options={})
      @errors = {}
      @attributes = Util.stringify_keys(options)
      @client = @attributes.delete("client")
      @resource_type = @attributes.delete("resource_type")
    end

    def method_missing(meth, *args, &block)
      attributes[meth.to_s]
    end

    def save
      if url
        response = client.put(url, resource_type => attributes)
      else
        response = client.post("/#{resource_type}s", resource_type => attributes)
      end
      apply_response(response)
      return self
    end

    def apply_response(response)
      object = JSON.parse(response.body)
      if response.success?
        @attributes = object[resource_type]
      elsif response.code == 422
        @errors = object
      else
        raise Zipmark::Error.new(object)
      end
    end

    def valid?
      id && errors.empty?
    end

    def url
      link = links.detect {|link| link["rel"] == "self" } if links && !links.empty?
      link["href"] if link
    end
  end
end
