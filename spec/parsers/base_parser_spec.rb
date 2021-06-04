RSpec.describe OscnScraper::Parsers::BaseParser do
  describe '#build_object' do
    it 'parses html' do
      fixture_path = 'spec/fixtures/example.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      described_class.new(parsed_html).build_object
      
      expect(true).to eq false
    end
  end
end
