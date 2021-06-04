RSpec.describe OscnScraper::Parsers::Events do
  describe '#parse' do
    it 'parses a case with many events' do
      fixture_path = 'spec/fixtures/parsers/events/multiple.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(false).to eq true
      # Test that all data is there
    end

    it 'parses a case with no events' do
      fixture_path = 'spec/fixtures/parsers/events/none.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(false).to eq true
      # Test that all data is there
    end
  end
end
