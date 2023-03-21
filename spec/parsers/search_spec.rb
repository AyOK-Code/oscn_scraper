RSpec.describe OscnScraper::Parsers::Search do
  context 'when search html passed' do
    it 'returns all cases on the page' do
      fixture_path = 'spec/fixtures/parsers/search/multiple_county_results.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)
      
      expect(data.count).to eq 56
    end
  end

  context 'when county is provided' do
    it 'filters results for that county' do
      fixture_path = 'spec/fixtures/parsers/search/multiple_county_results.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html, 'tulsa')

      expect(data.count).to eq 1
    end
  end

  context 'when multiple cases are listed for a county' do
    it 'returns multiple links' do
      fixture_path = 'spec/fixtures/parsers/search/multiple_cases_same_county.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html, 'oklahoma')

      expect(data.count).to eq 2
    end
  end

  context 'when no cases are found' do
    it 'returns empty array' do
      fixture_path = 'spec/fixtures/parsers/search/no_cases.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)
      
      expect(data).to eq []
    end
  end
end
