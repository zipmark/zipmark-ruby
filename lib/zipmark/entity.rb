module Zipmark
  class Entity
    attr_accessor :attributes, :client, :resource_type, :errors, :dirty_attributes

    def initialize(options={})
      @errors = {}
      @attributes = Util.stringify_keys(options)
      @dirty_attributes = {}
      @client = @attributes.delete("client")
      @resource_type = @attributes.delete("resource_type")
    end

    def inspect
      "<Entity:#{object_id} #{attributes.inspect}>"
    end

    def method_missing(meth, *args, &block)
      if meth =~ /=$/
        dirty_attributes[meth.to_s.sub(/=$/, '')] = args.first
      else
        dirty_attributes[meth.to_s] || attributes[meth.to_s]
      end
    end

    def save
      if url
        response = client.put(url, resource_type => dirty_attributes)
      else
        response = client.post("/#{resource_type}s", resource_type => attributes)
      end
      apply_response(response)
      return self
    end

    def apply_response(response)
      object = JSON.parse(response.body)
      if response.ok?
        @attributes = object[resource_type]
      elsif response.code == 422
        @errors = object
      else
        raise Zipmark::Error.new(object)
      end
    end

    def valid?
      !!(id && errors.empty?)
    end

    def url
      link = links.detect {|link| link["rel"] == "self" } if links && !links.empty?
      link["href"] if link
    end

    def updated_at
      Time.parse(attributes["updated_at"]) if attributes["updated_at"]
    end

    def  created_at
      Time.parse(attributes["created_at"]) if attributes["created_at"]
    end
  end
end
