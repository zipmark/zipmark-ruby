require 'spec_helper'

describe Zipmark::Callback do
  let(:app_id) { 'OWNjY2FiMmQtOWVhNy00OTVmLTg5YmEtOGQyMThjNWU1ZTg5' }
  let(:merchant_id) { 'test_vendor' }
  let(:app_secret) { '101e9484bf96d848e6e18a70b03cd894996d3b2f5ccf3775bfc8ff2c4b5ebf7858a10203ad816184d841b137b8de188825a77d35bb5a6a63b679453715b7e791' }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => app_secret, :vendor_identifier => merchant_id) }
  let(:time_string) { "Fri, 21 Sep 2012 22:04:37 -0000" }
  let(:request) {
    stub(
      :headers => {
        "Date" => time_string,
        "Authorization" => "ZM dGVzdF92ZW5kb3I=:Pl98fbL5+JugY+emf+tDINd5Kbo=",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      },
      :path => "/callback_url",
      :raw_post => '{"callback":{"event":"bill.create","object_type":"Bill","object":{"links":[{"rel":"self","href":"http://zipmark-service.dev/bills/3cac84ebc01670c57b0f1d73f2ea0e5a358a?scheme=http"}],"id":"3cac84ebc01670c57b0f1d73f2ea0e5a358a","amount_cents":1000,"memo":"test bill","identifier":"17e681ffcda7072a6ea81607","customer_id":"49328e7d3c22f79b07b0","currency":"USD","status":"open","recurring":false,"rendered_content":"test content","date":"2012-07-11","created_at":"2012-07-11T20:16:30Z","updated_at":"2012-07-11T20:16:30Z","vendor":{"links":[{"rel":"self","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36?scheme=http"},{"rel":"users","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/vendor_users?scheme=http"},{"rel":"applications","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/vendor_applications?scheme=http"},{"rel":"accounts","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/accounts?scheme=http"},{"rel":"bills","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bills?scheme=http"},{"rel":"bill_payments","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bill_payments?scheme=http"},{"rel":"bill_templates","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bill_templates?scheme=http"},{"rel":"integrations","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/integrations?scheme=http"}],"id":"3e919a6e-d8c1-11e0-9e1f-e394e5601a36","name":"Test Vendor","identifier":"test_vendor"}}}}'
    )
  }
  let(:callback) { callback = client.build_callback(request) }

  subject { callback }

  before do
    Timecop.freeze(Time.parse(time_string))
    Zipmark::Client.any_instance.stub(:load_resources).and_return({})
  end

  after { Timecop.return }

  it "should create a callback object" do
    callback.should be_kind_of(Zipmark::Callback)
  end

  it "should validate callback" do
    callback.should be_valid
  end
end

describe Zipmark::Callback, "bad credentials" do
  let(:app_id) { 'OWNjY2FiMmQtOWVhNy00OTVmLTg5YmEtOGQyMThjNWU1ZTg5' }
  let(:merchant_id) { 'test_vendor' }
  let(:secret) { 'badsecret' }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => secret, :vendor_identifier => merchant_id) }
  let(:time_string) { "Fri, 21 Sep 2012 22:04:37 -0000" }
  let(:request) {
    stub(
      :headers => {
        "Date" => time_string,
        "Authorization" => "ZM dGVzdF92ZW5kb3I=:Pl98fbL5+JugY+emf+tDINd5Kbo=",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      },
      :fullpath => "/callback_url",
      :raw_post => '{"callback":{"event":"bill.create","object_type":"Bill","object":{"links":[{"rel":"self","href":"http://zipmark-service.dev/bills/3cac84ebc01670c57b0f1d73f2ea0e5a358a?scheme=http"}],"id":"3cac84ebc01670c57b0f1d73f2ea0e5a358a","amount_cents":1000,"memo":"test bill","identifier":"17e681ffcda7072a6ea81607","customer_id":"49328e7d3c22f79b07b0","currency":"USD","status":"open","recurring":false,"rendered_content":"test content","date":"2012-07-11","created_at":"2012-07-11T20:16:30Z","updated_at":"2012-07-11T20:16:30Z","vendor":{"links":[{"rel":"self","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36?scheme=http"},{"rel":"users","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/vendor_users?scheme=http"},{"rel":"applications","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/vendor_applications?scheme=http"},{"rel":"accounts","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/accounts?scheme=http"},{"rel":"bills","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bills?scheme=http"},{"rel":"bill_payments","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bill_payments?scheme=http"},{"rel":"bill_templates","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bill_templates?scheme=http"},{"rel":"integrations","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/integrations?scheme=http"}],"id":"3e919a6e-d8c1-11e0-9e1f-e394e5601a36","name":"Test Vendor","identifier":"test_vendor"}}}}'
    )
  }
  let(:callback) { callback = client.build_callback(request) }

  before do
    Timecop.freeze(Time.parse(time_string))
    Zipmark::Client.any_instance.stub(:load_resources).and_return({})
    callback.valid?
  end

  after do
    Timecop.return
  end

  subject { callback }

  it { should_not be_valid }
  its(:errors) { should eq(:authorization => "Signature does not match.") }
end

describe Zipmark::Callback, "out of bounds date" do
   let(:app_id) { 'OWNjY2FiMmQtOWVhNy00OTVmLTg5YmEtOGQyMThjNWU1ZTg5' }
  let(:merchant_id) { 'test_vendor' }
  let(:secret) { '101e9484bf96d848e6e18a70b03cd894996d3b2f5ccf3775bfc8ff2c4b5ebf7858a10203ad816184d841b137b8de188825a77d35bb5a6a63b679453715b7e791' }
  let(:client) { Zipmark::Client.new(:application_id => app_id, :application_secret => secret, :vendor_identifier => merchant_id) }
  let(:time_string) { "Fri, 21 Sep 2012 22:04:37 -0000" }
  let(:request) {
    stub(
      :headers => {
        "Date" => time_string,
        "Authorization" => "ZM dGVzdF92ZW5kb3I=:Pl98fbL5+JugY+emf+tDINd5Kbo=",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      },
      :fullpath => "/callback_url",
      :raw_post => '{"callback":{"event":"bill.create","object_type":"Bill","object":{"links":[{"rel":"self","href":"http://zipmark-service.dev/bills/3cac84ebc01670c57b0f1d73f2ea0e5a358a?scheme=http"}],"id":"3cac84ebc01670c57b0f1d73f2ea0e5a358a","amount_cents":1000,"memo":"test bill","identifier":"17e681ffcda7072a6ea81607","customer_id":"49328e7d3c22f79b07b0","currency":"USD","status":"open","recurring":false,"rendered_content":"test content","date":"2012-07-11","created_at":"2012-07-11T20:16:30Z","updated_at":"2012-07-11T20:16:30Z","vendor":{"links":[{"rel":"self","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36?scheme=http"},{"rel":"users","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/vendor_users?scheme=http"},{"rel":"applications","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/vendor_applications?scheme=http"},{"rel":"accounts","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/accounts?scheme=http"},{"rel":"bills","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bills?scheme=http"},{"rel":"bill_payments","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bill_payments?scheme=http"},{"rel":"bill_templates","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/bill_templates?scheme=http"},{"rel":"integrations","href":"http://zipmark-service.dev/vendors/3e919a6e-d8c1-11e0-9e1f-e394e5601a36/integrations?scheme=http"}],"id":"3e919a6e-d8c1-11e0-9e1f-e394e5601a36","name":"Test Vendor","identifier":"test_vendor"}}}}'
    )
  }
  let(:callback) { callback = client.build_callback(request) }

  before do
    Timecop.freeze(Time.parse(time_string) + 1200)
    Zipmark::Client.any_instance.stub(:load_resources).and_return({})
    callback.valid?
  end

  after do
    Timecop.return
  end

  subject { callback }

  it { should_not be_valid }
  its(:errors) { should eq(:date => "Date is not within bounds.") }
end
