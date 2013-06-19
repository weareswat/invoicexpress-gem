require 'helper'

describe Invoicexpress::Client::Schedules do
  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".schedules" do
    it "Returns all the schedules" do
      stub_get("/schedules.xml").
        to_return(xml_response("schedules.list.xml"))

      list = @client.schedules
      list.count.should == 1
      list.first.client.id==439232
      list.first.items.size==1
    end
  end

  describe ".schedule" do
    it "gets a schedule" do
      stub_get("/schedules/4307.xml").
        to_return(xml_response("schedules.get.xml"))

      c = @client.schedule("4307")
      c.id.should == 4307
      c.retention.should == 5.0
    end
  end

end

