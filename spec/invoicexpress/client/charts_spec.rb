require 'helper'

describe Invoicexpress::Client::Charts do

  before do
    @client = Invoicexpress::Client.new(:screen_name => "thinkorangeteste")
  end

  describe ".invoicing_chart" do
    it "Returns the invoicing chart data." do
      stub_get("/api/charts/invoicing.xml").
        to_return(xml_response("charts.invoicing.xml"))

      chart = @client.invoicing_chart

      expect(chart.series.values.count).to eq 6
      expect(chart.graphs.first.values.count).to eq 6
    end
  end

  describe ".treasury_chart" do
    it "Returns the treasury chart data." do
      stub_get("/api/charts/treasury.xml").
        to_return(xml_response("charts.treasury.xml"))

      chart = @client.treasury_chart

      expect(chart.series.values.count).to eq 7
      expect(chart.graphs.count).to eq 4
      expect(chart.graphs.first.values.count).to eq 7

    end
  end

  describe ".top_clients" do
    it "Returns the top 5 clients." do
       stub_get("/api/charts/top-clients.xml").
         to_return(xml_response("charts.top-clients.xml"))

       chart = @client.top_clients

       expect(chart.clients.first.name).to eq "Ruben Fonseca"
       expect(chart.clients.size).to eq 1
    end
  end

  describe ".top_debtors" do
    it "Returns the top 5 debtors." do
       stub_get("/api/charts/top-debtors.xml").
         to_return(xml_response("charts.top-debtors.xml"))

       chart = @client.top_debtors
       expect(chart.clients.size).to eq 1
       expect(chart.clients.first.name).to eq "Ruben Fonseca"
    end
  end

  describe ".quarterly_results" do
    it "return all the quarterly results." do
      stub_get("/api/charts/quarterly-results.xml?year=2010").
        to_return(xml_response("charts.quarterly-results.xml"))

      list = @client.quarterly_results(2010)
      expect(list.quarter01.invoicing).to eq 60.0
      expect(list.year).to eq 2010

   end
  end

end
