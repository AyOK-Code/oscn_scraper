RSpec.describe OscnScraper::Parsers::BaseParser do
  describe '#build_object' do
    it 'parses html' do
      fixture_path = 'spec/fixtures/example.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.new(parsed_html).build_object

      expect(data[:events].count).to eq 30
      expect(data[:attorneys].count).to eq 2
      expect(data[:parties].count).to eq 4
      expect(data[:counts].count).to eq 9
      expect(data[:docket_events].count).to eq 247
    end
  end
end
