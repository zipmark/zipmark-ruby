module Zipmark
  class Collection
    include Enumerable

    attr_accessor :object_type, :iterator

    def initialize(object_type, item_json, iterator_class = Zipmark::Iterator)
      @iterator = iterator_class.new(item_json)
    end

    def items
      iterator.current_items
    end

    def length
      iterator.total_items
    end

    def each
      yield iterator.current_item while iterator.next_item
    end
  end
end
