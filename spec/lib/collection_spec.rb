require 'spec_helper'

describe Zipmark::Collection do
  let(:json) {  mock('json') }
  let(:mock_iterator) { mock('iterator') }
  let(:mock_iterator_instance) { mock('iterator instance') }
  let(:collection) { Zipmark::Collection.new("object_type", json, mock_iterator) }

  subject { collection}

  before do
    mock_iterator.should_receive(:new).and_return(mock_iterator_instance)
  end

  it "should have three items" do
    mock_iterator_instance.should_receive(:current_items).and_return([1,2,3])
    collection.items.length.should == 3
  end

  it "should return the total number of items" do
    mock_iterator_instance.should_receive(:total_items).and_return(15)
    collection.length.should == 15
  end
end
