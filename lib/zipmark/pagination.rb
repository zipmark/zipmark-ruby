module Zipmark
  class Pagination
    attr_accessor :pagination_hash

    def initialize(hash)
      raise ArgumentError, "expected hash" unless hash && hash.kind_of?(Hash)
      @pagination_hash = hash
    end

    def pages
      pagination_hash["total_pages"]
    end

    def total
      pagination_hash["total"]
    end

    def per_page
      pagination_hash["per_page"]
    end

    def current_page
      pagination_hash["page"]
    end

    def first_page?
      pagination_hash["first_page"]
    end

    def last_page?
      pagination_hash["last_page"]
    end
  end
end
