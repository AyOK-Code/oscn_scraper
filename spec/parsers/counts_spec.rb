RSpec.describe OscnScraper::Parsers::Counts do
  describe '#parse' do
    it 'parses a case with multiple counts' do
      fixture_path = 'spec/fixtures/parsers/counts/multiple.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(false).to eq true
      # Test that all data is there
    end

    it 'parses a single count' do
      fixture_path = 'spec/fixtures/parsers/counts/single.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(false).to eq true
      # Test that script does not break
      # Test that script bar number is nil
    end

    it 'parses a counts without disposition info' do
      fixture_path = 'spec/fixtures/parsers/counts/no_disposition.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(false).to eq true
      # Test that script does not break
      # Test that script bar number is nil
    end

    it 'skips counts that do not have parties attached' do
      fixture_path = 'spec/fixtures/parsers/counts/missing_party'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

    end
  end
end
