RSpec.describe OscnScraper::Requestor::Case do
  describe '#new' do
    it 'only accepts valid parameters' do
      args = { county: 'Oklahoma', case_number: 'CF-2020-124' }

      expect { described_class.new(args) }.to raise_error OscnScraper::Errors::InvalidParam
    end
  end

  describe '#fetch_case_by_number(kwargs = {})' do
    it 'needs required params' do
      args = { county: 'Oklahoma' }

      expect { described_class.new(args).fetch_case_by_number }.to raise_error OscnScraper::Errors::RequiredParam
    end
  end


  describe '#fetch_case_by_number(kwargs = {})' do
    it 'needs required params' do

      args = { county: 'Tulsa', case_number: 'TR-2022-5899', cmid: 3526063 }

        described_class.new(args).fetch_case_by_number
    end
  end
end
