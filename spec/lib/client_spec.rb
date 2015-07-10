require 'spec_helper'

describe Zipmark::Client do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:default_adapter) { Zipmark::Adapters::HTTPClientAdapter }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret) }

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

  describe "#display" do
    it 'it returns a DisplayProxy' do
      client.display.should be_a(DisplayProxy)
    end

    it 'sets itself to the client on the DisplayProxy' do
      proxy = client.display
      proxy.client.should eql(client)
    end
  end

  describe "#workflow" do
    it 'it returns a WorkflowProxy' do
      client.workflow.class.should eql(WorkflowProxy)
    end

    it 'sets itself to the client on the WorkflowProxy' do
      proxy = client.workflow
      proxy.client.should eql(client)
    end
  end
end
