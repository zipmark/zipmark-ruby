require 'spec_helper'

describe DisplayProxy do
  let(:client) { stub }
  let(:proxy) { described_class.new(client) }

  describe "#create" do
    it 'returns a Workflow' do
      proxy.create.class.should eql(Display)
    end

    it 'sets itself as the client' do
      proxy.create.client.should eql(client)
    end
  end
end
