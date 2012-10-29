require 'spec_helper'

describe Zipmark::Collection do
  let(:mock_client) { mock("client") }
  let(:mock_resource) { mock('resource') }
  let(:mock_response) {mock("response") }
  let(:mock_iterator) { mock('iterator') }
  let(:mock_iterator_instance) { mock('iterator instance') }
  let(:collection) { Zipmark::Collection.new(mock_resource, mock_iterator) }

  subject { collection}

  before do
    mock_resource.should_receive(:rel).and_return("bills")
    mock_resource.should_receive(:href).and_return("https://example.com")
    mock_resource.should_receive(:client).twice.and_return(mock_client)
    mock_client.should_receive(:get).and_return(mock_response)
    mock_response.should_receive(:body).and_return("{}")
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
