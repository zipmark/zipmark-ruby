require 'spec_helper'

describe Zipmark::Pagination do
  let(:json) {  fixture('pagination.json' ).read }
  let(:pagination) { Zipmark::Pagination.new(JSON.parse(json)) }

  subject { pagination }

  its(:pages) { should be(3) }
  its(:total) { should be(8) }
  its(:current_page) { should be(1) }
  its(:first_page?) { should be(true) }
  its(:last_page?) { should be(false) }
end
