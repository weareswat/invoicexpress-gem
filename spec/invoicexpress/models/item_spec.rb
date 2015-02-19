require 'helper'

describe Invoicexpress::Models::Item do

  describe '#tax' do
    let(:item) do
      Invoicexpress::Models::Item.parse(File.read(fixture('/item.xml')))
    end

    it 'returns an Invoicexpress::Models::Tax instance' do
      expect(item.tax).to be_a Invoicexpress::Models::Tax
    end
  end

end