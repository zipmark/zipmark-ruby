require 'spec_helper'

describe Workflow do
  let(:adapter)       { stub(:password => 'password', :username => 'username') }
  let(:client)        { stub(:adapter => adapter) }
  let(:workflow_name) { 'enrollment' }
  let(:data)          { { customer_id: SecureRandom.uuid } }
  let(:workflow)      { described_class.new(client:  client,
                                            name:    workflow_name,
                                            data:    data ) }

  let(:jwt) { JWT.encode(
                {
                  workflow:       workflow_name,
                  application_id: client.adapter.username,
                  iat:            Time.now.to_i,
                  data:           data
                  },
                  client.adapter.password
              )
            }

  describe "#token" do
    it 'encodes a JWT' do
      workflow.token.should eql(jwt)
    end
  end
end
