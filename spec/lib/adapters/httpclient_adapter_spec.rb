require 'spec_helper'

describe Zipmark::Adapters::HTTPClientAdapter do
  let(:ssl_stub)    { stub(:ssl_version= => true)}
  let(:client_stub) { stub(:ssl_config => ssl_stub, :set_auth => true)}

  describe "#initialize_client" do
    it 'sets default headers and forces basic auth' do
      HTTPClient.should_receive(:new).with(
        default_header: { 'Content-Type' => 'application/json', 'Accept' => "application/vnd.com.zipmark.v3+json" },
        force_basic_auth: true
      ).and_return(client_stub)
      described_class.new.initialize_client
    end
  end
end
