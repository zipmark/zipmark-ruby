require 'spec_helper'

describe Zipmark::Client do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:default_adapter) { Zipmark::Adapters::HTTPClientAdapter }
  let(:client) { Zipmark::Client.new(app_id, app_secret) }

  subject { client }

  before do
    Zipmark::Client.any_instance.stub(:load_resources).and_return({})
  end

  it { should respond_to(:adapter) }

  it "should have default http adapter class" do
    client.adapter.should be_a(default_adapter)
  end

  it "should send get requests to the adapter" do
    client.adapter.should_receive(:get).with("/")
    client.get("/")
  end
end
