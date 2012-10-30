module Zipmark
  class Resource
    attr_accessor :options

    def initialize(options={})
      @options = Util.stringify_keys(options)
    end

    def all
      Zipmark::Collection.new(self, Zipmark::Iterator)
    end

    def find(id)
      json = client.get("/" + rel + "/" + id).body
      object = JSON.parse(json)
      Zipmark::Entity.new(object[resource_name])
    end

    def build(options)
      Zipmark::Entity.new(options.merge(:client => client, :resource_type => resource_name))
    end

    def create(options)
      entity = build(options)
      entity.save
    end

    def href
      options["href"] || raise(Zipmark::ResourceError, "Resource did not specify href")
    end

    def rel
      options["rel"] || raise(Zipmark::ResourceError, "Resource did not specify rel")
    end

    def resource_name
      #TODO: This is a hack
      rel.gsub(/s$/, '')
    end

    def client
      options["client"] || raise(Zipmark::ClientError, "You must pass :client as an option")
    end
  end
end
