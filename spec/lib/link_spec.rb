require 'spec_helper'

describe Zipmark::Link do
  let(:options) { {:rel => "web", :href => "http://www.example.com/bills/abcdef", :title => "HTML Rendered Bill"} }
  let(:link) { Zipmark::Link.new(options) }

  subject { link }

  its(:rel) { should == options[:rel] }
  its(:href) { should == options[:href] }
  its(:title) { should == options[:title] }
end
