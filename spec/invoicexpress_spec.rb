require 'helper'

describe Invoicexpress do
  after do
    Invoicexpress.reset
  end

  describe ".new" do
    it "is a Invoicexpress::Client" do
      Invoicexpress.new.should be_a Invoicexpress::Client
    end
  end

  describe ".responds_to?" do
    it "is true if method exists" do
      Invoicexpress.respond_to?(:new, true).should == true
    end
  end
end
