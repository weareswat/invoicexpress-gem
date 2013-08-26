require 'helper'

describe Invoicexpress::Client::Clients do

  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".login" do
    it "logins with your account" do
      stub_post("/login.xml").
        to_return(xml_response("users.login.xml"))

      list= @client.login("info@test.pt", "2xptopxto")
      list.count.should == 1
      list.first.name.should == "thinkorangeteste"
    end
  end

   describe ".accounts" do
    it "returns all the accounts" do
      stub_get("/users/accounts.xml").
        to_return(xml_response("users.accounts.xml"))

      list = @client.accounts
      list.count.should == 1
      list.first.name.should == "thinkorangeteste"
    end
  end
  
  describe ".change-account" do
    it "changes the current account to the account id submitted" do
      stub_put("/users/change-account.xml").
        to_return(xml_response("users.change-account.xml"))
        
      expect { cnote = @client.change_account(13233) }.to_not raise_error
    end
  end

end
