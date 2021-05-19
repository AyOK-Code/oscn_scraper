RSpec.describe OscnScraper::Parsers::DocketEvents do
  describe '#parse' do
    it 'parses a case with many docket events' do
      html = File.open('spec/fixtures/parsers/docket_events/multiple.html').read
      Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that all data is there
    end

    it 'parses another example case with many docket events' do
      html = File.open('spec/fixtures/parsers/docket_events/multiple.html').read
      Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that all data is there
    end
  end
end
