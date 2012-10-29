require 'json'

module Zipmark
  class Iterator
    attr_accessor :current_item, :json, :options

    def initialize(json, options = {})
      @json = JSON.parse(json)
      @options = options
      @current_item = items.first
    end

    def client
      options[:client]
    end

    def collection
      json[options[:resource_name]]
    end

    def metadata
      json["meta"]
    end

    def links
      json["links"]
    end

    def items
      @items ||= collection.map {|item| Entity.new(item) }
    end

    def pagination
      @pagination ||= Pagination.new(metadata["pagination"] ) if metadata
    end

    def next_item
      item =  @items.fetch(@items.index(current_item) + 1) rescue nil
      if item
        @current_item = item
      else
        @current_item = fetch_item_from_next_page ? @items.fetch(0) : nil
      end
    end

    def fetch_item_from_next_page
      return if pagination.last_page?
      self.json = client.get(next_page["href"])
      @items = nil
      @pagination = nil
      @current_item = items.first
      return true
    end

    def next_page
      links.detect {|l| l["rel"] == "next"}
    end

    def total_items
      pagination.total if pagination
    end

    def pages
      pagination.pages if pagination
    end
  end
end
