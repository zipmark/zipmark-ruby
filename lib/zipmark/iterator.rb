require 'json'

module Zipmark
  class Iterator
    attr_accessor :current_item, :json, :pagination

    def initialize(json)
      @json = JSON.parse(json)
      @current_item = items.first
    end

    def metadata
      json["meta"]
    end

    def items
    end

    def pagination
      @pagination ||= Pagination.new(metadata["pagination"] ) if metadata
    end

    def total_items
      pagination.total if pagination
    end

    def pages
      pagination.pages if pagination
    end
  end
end
