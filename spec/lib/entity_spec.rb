require 'spec_helper'

describe Zipmark::Entity do
  let(:options) { {} }
  let(:item) { Zipmark::Entity.new(options) }

  subject { item }

  its(:options) { should == Zipmark::Util.stringify_keys(options) }
end
