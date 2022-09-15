require 'byebug'
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
    it 'needs required oscn' do
      args = { county: 'Tulsa',oscn:3526063}
      response_body = File.read('spec/fixtures/cmid_fixture.html')
      
      stub_request(:get, "https://www.oscn.net/dockets/GetCaseInformation.aspx?cmid=3526063&db=tulsa").
         with(
           headers: {
       	  'Accept'=>'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
       	  'Accept-Encoding'=>'gzip, deflate, br',
       	  'Accept-Language'=>'en-US,en;q=0.9,es;q=0.8',
       	  'User-Agent'=>'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36'
           }).
         to_return(status: 200, body: response_body, headers: {})
       results = described_class.new(args).fetch_case_by_number
       expect(results.parsed_response).to include 'TR-2022-5899'
        
       
    end
  end

end
