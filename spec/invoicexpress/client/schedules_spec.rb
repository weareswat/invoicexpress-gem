require 'helper'

describe Invoicexpress::Client::Schedules do
  before do
    @client = Invoicexpress::Client.new(:account_name => "thinkorangeteste")
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
      stub_get("/schedules/4462.xml").
        to_return(xml_response("schedules.get.xml"))

      c = @client.schedule(4462)
      c.id.should == 4462
      c.sum.should == 360.0
    end
  end

  describe ".update_schedule" do
    it "updates the schedule" do
      stub_put("/schedules/4462.xml").
        to_return(xml_response("ok.xml"))

      model = Invoicexpress::Models::Schedule.new(
        :id=>4462,
        :start_date => Date.new(2013, 6, 16),
        :end_date => Date.new(2013, 8, 18),
        :create_back => "Yes",
        :schedule_type => "Monthly",
        :interval => 2,
        :send_to_client => "No",
        :description=> "created from API.",
        :invoice_template=> Invoicexpress::Models::InvoiceTemplate.new(
          :due_days=>1,
          :client => Invoicexpress::Models::Client.new(
            :name => "Chuck Norris",
            :email=>'chuck@thinkorange.pt'
          ),
          :items => [
            Invoicexpress::Models::Item.new(
              :name => "Item 1",
              :unit_price => 30,
              :quantity => 2,
              :unit => "unit",
              :tax=>Invoicexpress::Models::Tax.new(
                :name => "IVA23",
              )
            ),
            Invoicexpress::Models::Item.new(
              :name => "Item 2",
              :unit_price => 60,
              :quantity => 5,
              :unit => "unit",
              :tax=>Invoicexpress::Models::Tax.new(
                :name => "IVA23",
              )
            )
          ]
        )
      )

      expect { @client.update_schedule(model) }.to_not raise_error
    end

    it "raises if no schedule is passed" do
      expect {
        @client.update_schedule(nil)
      }.to raise_error(ArgumentError)
    end

    it "raises if the schedule to update has no id" do
      stub_put("/schedules/.xml").
        to_return(xml_response("ok.xml"))
      expect {
        @client.update_schedule(Invoicexpress::Models::Schedule.new)
      }.to raise_error(ArgumentError)
    end
  end

  describe ".activate_schedule" do
    it "activates the schedule" do
      stub_put("/schedules/4462/activate").
        to_return(xml_response("ok.xml"))
      model = Invoicexpress::Models::Schedule.new(:id=>4462)
      expect { item = @client.activate_schedule(model) }.to_not raise_error
    end
  end

  describe ".deactivate_schedule" do
    it "deactivates the schedule" do
      stub_put("/schedules/4462/deactivate").
        to_return(xml_response("ok.xml"))
      model = Invoicexpress::Models::Schedule.new(:id=>4462)
      expect { item = @client.deactivate_schedule(model) }.to_not raise_error
    end
  end

end

