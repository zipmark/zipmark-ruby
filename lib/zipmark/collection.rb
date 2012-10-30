module Zipmark
  class Collection
    include Enumerable

    attr_accessor :iterator

    def initialize(resource, iterator_class)
      fetched_resource = resource.client.get(resource.href)
      @iterator = iterator_class.new(fetched_resource.body, :resource_name => resource.rel, :client => resource.client)
    end

    def items
      iterator.current_items
    end

    def length
      iterator.total_items
    end

    def each
      # Wrapping in the being block ensures that the current_item is returned once before next_item is called
      begin
        yield iterator.current_item
      end while iterator.next_item
    end
  end
end
