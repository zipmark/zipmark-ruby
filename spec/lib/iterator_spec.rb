require 'spec_helper'

describe Zipmark::Iterator do
  let(:json) {  fixture('iterator.json' ).read }
  let(:iterator) { Zipmark::Iterator.new(json, :resource_name => "bills") }

  subject { iterator }

  its(:pages) { should be(3) }
  its(:total_items) { should be(8) }
  its(:current_item) { should be_a(Zipmark::Entity) }
  its(:next_item) { should be(iterator.items[1]) }
end
