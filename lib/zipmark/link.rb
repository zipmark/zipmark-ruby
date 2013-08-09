module Zipmark
  class Link
    attr_accessor :rel, :title, :href

    def initialize(options)
      link = Util.stringify_keys(options)
      @rel = link["rel"]
      @title = link["title"]
      @href = link["href"]
    end
  end
end
