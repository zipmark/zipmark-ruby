require 'spec_helper'

describe "fetching a list of bills" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(app_id, app_secret) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list'))
    stub_request(:get, "http://example.org/bills").to_return(http_fixture("bills/list"))
  end

  it "should produce a collection of bills" do
    client.bills.find_all.should be_a(Zipmark::Collection)
  end

  it "should have 22 bills in it" do
    client.bills.find_all.length.should be(22)
  end
end

describe "fetching a list of bills with more than one page" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(app_id, app_secret) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list'))
    stub_request(:get, "http://example.org/bills").to_return(http_fixture("bills/list_p1_of_3"))
  end

  it "should produce a collection of bills" do
    client.bills.find_all.should be_a(Zipmark::Collection)
  end

  it "should have 8 bills in it" do
    client.bills.find_all.length.should be(8)
  end

  it "should be able to iterate over all 8 bills and get an attirbute" do
    bill_amounts = client.bills.find_all.map(&:amount)
    bill_amounts.length.should be(8)
  end
end
