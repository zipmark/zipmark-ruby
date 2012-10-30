require 'spec_helper'

describe "creating a new bill with #create" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(app_id, app_secret) }
  let(:options) {
    {
      :identifier       => 'testbill8',
      :amount_cents     => 12345,
      :bill_template_id => '7eadd7be-60eb-4054-a172-107d394585e2',
      :memo             => 'Test Bill #8',
      :date             => '2012-09-10',
      :content          => '{"content":"foo"}'
    }
  }

  let(:bill) { client.bills.create(options) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list'))
    stub_request(:post, "https://sandbox.zipmark.com/bills").to_return(http_fixture("bills/create"))
  end

  it "should create a new entity" do
    bill.should be_kind_of(Zipmark::Entity)
  end

  it "should be valid" do
    bill.should be_valid
  end

  it "should now have a url" do
    bill.url.should eq("http://example.org/bills/3ce95db62b1069e59e122c515eb191c70987")
  end

  it "should have an id"  do
    bill.id.should eq("3ce95db62b1069e59e122c515eb191c70987")
  end
end

describe "creating a new bill with #create and getting validation errors" do
  let(:app_id) { "my-app-id" }
  let(:app_secret) { "my-app-secret" }
  let(:client) { Zipmark::Client.new(app_id, app_secret) }

  let(:bill) { client.bills.create({}) }

  before do
    stub_request(:get, "https://sandbox.zipmark.com/").to_return(http_fixture('root_list'))
    stub_request(:post, "https://sandbox.zipmark.com/bills").to_return(http_fixture("bills/create_fail"))
  end

  it "should not be valid" do
    bill.should_not be_valid
  end

  it "should have an array of errors" do
    bill.errors.should_not be_empty
  end
end
