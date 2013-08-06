require 'spec_helper'

describe "fetching an individual bill" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }
  let(:bill_id) { "testbillid" }
  let(:invalid_bill_id) { "invalidbillid" }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list'))
    stub_request(:get, "https://sandbox.zipmark.com/bills/testbillid").to_return(http_fixture('bills/get'))
    stub_request(:get, "https://sandbox.zipmark.com/bills/invalidbillid").to_return(http_fixture('bills/get_fail'))
  end

  it "should return an individual bill" do
    client.bills.find(bill_id).should be_a(Zipmark::Entity)
  end

  it "should respond to bill attributes" do
    client.bills.find(bill_id).amount_cents.should eq(1000)
  end

  it "should raise an error when the bill can't be found" do
    expect { client.bills.find(invalid_bill_id) }.to raise_error(Zipmark::Error)
  end
end
