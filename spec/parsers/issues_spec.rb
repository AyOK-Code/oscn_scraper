RSpec.describe OscnScraper::Parsers::Issues do
  describe '#parse' do
    it 'parses a single issue' do
      fixture_path = 'spec/fixtures/parsers/issues/one-party.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('body').children
      data = described_class.parse(parsed_html)
      
      expect(data[:issues].count).to eq 1
      expect(data[:issues].first[:number]).to eq '1'
      expect(data[:issues].first[:issue_name]).to eq "FORCIBLE ENTRY & DETAINER <$5000.00."
      expect(data[:issues].first[:issue_code]).to eq "SCFED1"
      expect(data[:issues].first[:parties].count).to eq 1
      expect(data[:issues].first[:parties].first[:verdict]).to eq "DISMISSED"
    end

    it 'parses an issue with two parties' do
      fixture_path = 'spec/fixtures/parsers/issues/two-party.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('body').children
      data = described_class.parse(parsed_html)
      
      expect(data[:issues].count).to eq 1
      expect(data[:issues].first[:number]).to eq '1'
      expect(data[:issues].first[:issue_name]).to eq "FORCIBLE ENTRY & DETAINER <$5000.00."
      expect(data[:issues].first[:issue_code]).to eq "SCFED1"
      expect(data[:issues].first[:parties].count).to eq 2
      expect(data[:issues].first[:parties].first[:verdict]).to eq "DEFAULT JUDGEMENT"
    end

    it 'parses an issue with three parties' do
      fixture_path = 'spec/fixtures/parsers/issues/three-party.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('body').children
      data = described_class.parse(parsed_html)
      
      expect(data[:issues].count).to eq 1
      expect(data[:issues].first[:number]).to eq '1'
      expect(data[:issues].first[:issue_name]).to eq "FORCIBLE ENTRY & DETAINER <$5000.00."
      expect(data[:issues].first[:issue_code]).to eq "SCFED1"
      expect(data[:issues].first[:parties].count).to eq 3
      expect(data[:issues].first[:parties].first[:verdict]).to eq "DEFAULT JUDGEMENT"
    end

    it 'parses an issue without a disposition' do
      fixture_path = 'spec/fixtures/parsers/issues/no-disposition.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('body').children
      data = described_class.parse(parsed_html)
      
      expect(data[:issues].count).to eq 1
      expect(data[:issues].first[:parties].count).to eq 0
    end
  end
end
