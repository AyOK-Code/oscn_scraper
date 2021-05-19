RSpec.describe OscnScraper::Parsers::Events do
  describe '#parse' do
    it 'parses a case with many events' do
      path = 'spec/fixtures/parsers/events/multiple.html'
      html = File.open(path).read
      parsed_html = Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that all data is there
    end

    it 'parses a case with no events' do
      path = 'spec/fixtures/parsers/events/none.html'
      html = File.open(path).read
      parsed_html = Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that all data is there
    end
  end
end
