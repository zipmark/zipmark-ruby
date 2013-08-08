module Zipmark
  class Link
    attr_accessor :name, :title, :href

    def initialize(options)
      link = Util.stringify_keys(options)
      @rel = link["rel"]
      @title = link["title"]
      @href = link["href"]
    end

    def rel
      @rel
    end

    def title
      @title
    end

    def href
      @href
    end
  end
end
