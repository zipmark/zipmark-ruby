require 'spec_helper'

describe "fetching an individual bill" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(app_id, app_secret) }
  let(:bill_id) { "testbillid" }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list'))
    stub_request(:get, "https://sandbox.zipmark.com/bills/testbillid").to_return(http_fixture('bills/get'))
  end

  it "should return an individual bill" do
    client.bills.find(bill_id).should be_a(Zipmark::Entity)
  end

  it "should respond to bill attributes" do
    client.bills.find(bill_id).amount_cents.should eq(1000)
  end
end
