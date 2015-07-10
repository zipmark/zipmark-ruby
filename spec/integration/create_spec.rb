require 'spec_helper'

describe "creating a new deposit with #create" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }

  let(:body)    { { :customer_identifier => 'c93e6eb9-222d-4d9b-8233-8bed2092abc9', :amount_cents => 5000, :memo => 'For blogging excellently' } }
  let(:deposit) { client.deposits.create(body) }

  before do
    # stub_request(:get, "https://sandbox.zipmark.com").to_return('')
    stub_request(:get, "https://sandbox.zipmark.com/").
      with(:headers => {'Accept'=>'application/vnd.com.zipmark.v3+json', 'Content-Type'=>'application/json'}).
      to_return(http_fixture('root/get'))

    stub_request(:post, "https://sandbox.zipmark.com/deposits").
      to_return(http_fixture('deposits/create'))
  end

  it "should create a new entity" do
    deposit.should be_kind_of(Zipmark::Entity)
  end

  it "should be valid" do
    deposit.should be_valid
  end

  it "should now have a url" do
    deposit.links.length.should eq(1)
    deposit.links["self"].href.should eq("http://example.org/deposits/fbb2e07a-2f21-48a0-81fe-2f6c4b75e5f1")
  end

  it "should have an id"  do
    deposit.id.should eq("fbb2e07a-2f21-48a0-81fe-2f6c4b75e5f1")
  end
end

describe "creating a new deposit with #create and getting validation errors" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }

  let(:deposit) { client.deposits.create({}) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").
             with(:headers => {'Accept'=>'application/vnd.com.zipmark.v3+json', 'Content-Type'=>'application/json'}).
             to_return(http_fixture('root/get'))
    stub_request(:post, "https://sandbox.zipmark.com/deposits").to_return(http_fixture("deposits/create_fail"))
  end

  it "should not be valid" do
    deposit.should_not be_valid
  end

  it "should have an array of errors" do
    deposit.errors.should_not be_empty
  end
end
