require 'spec_helper'

describe "fetching an individual deposit" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }
  let(:deposit_id) { "testbillid" }
  let(:invalid_id) { "invalidbillid" }
  let(:callback_id) { "testcallbackid" }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root/get'))
    stub_request(:get, "https://sandbox.zipmark.com/deposits/testbillid").to_return(http_fixture('deposits/get'))
    stub_request(:get, "https://sandbox.zipmark.com/deposits/invalidbillid").to_return(http_fixture('deposits/get_fail'))
  end

  it "should return an individual deposit" do
    client.deposits.find(deposit_id).should be_a(Zipmark::Entity)
  end

  it "should respond to deposit attributes" do
    client.deposits.find(deposit_id).amount_cents.should eq(1000)
  end

  it "should raise an error when the deposit can't be found" do
    expect { client.deposits.find(invalid_id) }.to raise_error(Zipmark::Error)
  end
end
