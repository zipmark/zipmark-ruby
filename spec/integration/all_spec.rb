require 'spec_helper'

describe "fetching a list of deposits" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").
      with(:headers => {'Accept'=>'application/vnd.com.zipmark.v3+json', 'Content-Type'=>'application/json'}).
      to_return(http_fixture('root/get'))
    stub_request(:get, "http://example.org/deposits").to_return(http_fixture("deposits/list"))
  end

  it "should produce a collection of deposits" do
    client.deposits.all.should be_a(Zipmark::Collection)
  end

  it "should have 16 deposits in it" do
    client.deposits.all.length.should be(16)
  end
end

describe "fetching a list of deposits with more than one page" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root/get'))
    stub_request(:get, "http://example.org/deposits").to_return(http_fixture("deposits/list"))
  end

  it "should produce a collection of deposits" do
    client.deposits.all.should be_a(Zipmark::Collection)
  end

  it "should have 16 deposits in it" do
    client.deposits.all.length.should be(16)
  end

  it "should be able to iterate over all 16 deposits and get an attribute" do
    deposit_amounts = client.deposits.all.map(&:amount_cents)
    deposit_amounts.length.should be(16)
  end
end

describe "invalid credentials" do
  let(:app_id) { "bad_id" }
  let(:app_secret) { "bad_secret" }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list_error'))
  end

  it "should raise an error" do
    expect { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }.to raise_error(Zipmark::Error)
  end
end
