require 'oscn_scraper'
require 'byebug'
RSpec.describe OscnScraper::Parsers::PartyDetails do
  describe '.parse' do
    it ' takes fixture ,parses the data , and returns party details' do
      fixture_path = 'spec/fixtures/parsers/parties/party_details.html'
      html_doc = load_and_parse_fixture(fixture_path)
      data = described_class.parse(html_doc)
      expect(data.size).to eq 6
      expect(data[:record_date]).to eq '03/06/2018'
      expect(data[:addresses].first[:record_date]).to eq '03/06/2018'
    end
  end
end
