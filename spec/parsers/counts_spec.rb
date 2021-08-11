RSpec.describe OscnScraper::Parsers::Counts do
  describe '#parse' do
    it 'parses a case with multiple counts' do
      fixture_path = 'spec/fixtures/parsers/counts/multiple.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('.CountsContainer')
      data = described_class.parse(parsed_html)

      expect(data[:counts].count).to eq 2
      expect(data[:counts].first[:disposition]).to eq 'CONVICTION, 07/02/2018. Guilty Plea'
    end

    it 'parses a single count' do
      fixture_path = 'spec/fixtures/parsers/counts/single.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('.CountsContainer')
      data = described_class.parse(parsed_html)

      expect(data[:counts].count).to eq 1
      expect(data[:counts].first[:disposition]).to eq 'CONVICTION, 01/14/2020. Guilty Plea'
    end

    it 'parses a counts without disposition info' do
      fixture_path = 'spec/fixtures/parsers/counts/no_disposition_info.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('.CountsContainer')
      data = described_class.parse(parsed_html)

      expect(data[:counts].count).to eq 3
      expect(data[:counts].first[:as_filed]).to eq 'DRIVING WHILE UNDER THE INFLUENCE'
    end
  end
end
