module Zipmark
  class Entity
    attr_accessor :attributes, :client, :resource_type, :errors, :dirty_attributes, :links

    def initialize(options={})
      @errors = {}
      @attributes = Util.stringify_keys(options)
      @dirty_attributes = {}
      @client = @attributes.delete("client")
      @resource_type = @attributes.delete("resource_type")
      set_links
    end

    def set_links
      @links = {}
      object_links = @attributes.delete("links")
      if object_links.kind_of?(Array)
        object_links.each do |link|
          @links[link["rel"]] = Link.new(link)
        end
      end
    end

    def inspect
      "<Entity:#{object_id} #{attributes.inspect}>"
    end

    def id
      attributes["id"]
    end

    def indentifier
      attributes['identifier']
    end

    def method_missing(meth, *args, &block)
      if meth =~ /=$/
        dirty_attributes[meth.to_s.sub(/=$/, '')] = args.first
      else
        dirty_attributes[meth.to_s] || attributes[meth.to_s]
      end
    end

    def save
      if links["self"]
        response = client.put(links["self"].href, resource_type => dirty_attributes)
      else
        response = client.post("/#{resource_type}s", resource_type => attributes)
      end
      apply_response(response)
      return self
    end

    def apply_response(response)
      object = JSON.parse(response.body)
      if client.successful?(response)
        @attributes = object[resource_type]
        set_links
      elsif client.validation_error?(response)
        @errors = object["errors"]
      else
        raise Zipmark::Error.new(object)
      end
    end

    def valid?
      !!((id ||identifier) && errors.empty?)
    end

    def updated_at
      Time.parse(attributes["updated_at"]) if attributes["updated_at"]
    end

    def  created_at
      Time.parse(attributes["created_at"]) if attributes["created_at"]
    end
  end
end
