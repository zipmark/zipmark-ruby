require 'spec_helper'

describe Zipmark::Adapters::HTTPartyAdapter do
  let(:username) { "user" }
  let(:password) { "pass" }
  let(:adapter) { Zipmark::Adapters::HTTPartyAdapter.new }

  subject { adapter }

  it { should respond_to(:username) }
  it { should respond_to(:username=) }
  it { should respond_to(:password) }
  it { should respond_to(:password=) }
  it { should respond_to(:production) }
  it { should respond_to(:production=) }

  it { should respond_to(:get) }

  it "should use production api endpoint when production is true" do
    adapter.production = true
    adapter.api_endpoint.should be(Zipmark::PRODUCTION_API_ENDPOINT)
  end

  it "should use sandbox api endpoint when production is unset" do
    adapter.api_endpoint.should be(Zipmark::SANDBOX_API_ENDPOINT)
  end

  it "should use sandbox api endpoint when production is false" do
    adapter.api_endpoint.should be(Zipmark::SANDBOX_API_ENDPOINT)
  end

  it "should have accept mime type set" do
    adapter.api_accept_mime.should == "application/vnd.com.zipmark.v2+json"
  end
end
