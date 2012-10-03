require 'spec_helper'

describe Zipmark::Resource do
  let(:options) { {:rel => "bill", :href => "http://www.example.com/bills/abcdef"} }
  let(:resource) { Zipmark::Resource.new(options) }

  subject { resource }

  its(:options) { should == Zipmark::Util.stringify_keys(options) }
  its(:href) { should == options[:href] }
  its(:rel) { should == options[:rel] }
end
