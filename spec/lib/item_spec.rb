require 'spec_helper'

describe Zipmark::Item do
  let(:options) { {} }
  let(:item) { Zipmark::Item.new(options) }

  subject { item }

  its(:options) { should == Zipmark::Util.stringify_keys(options) }
end
