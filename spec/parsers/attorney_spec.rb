RSpec.describe OscnScraper::Parsers::Attorney do
  describe '#parse' do
    it 'parses a case with multiple attorneys' do
      fixture_path = 'spec/fixtures/parsers/attorney/multiple.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(data[:attorneys].count).to eq 2
      expect(data[:attorneys].include?({ name: 'ADLER, S THOMAS II', address: '', bar_number: '19997',
                                         represented_parties: 'PIT,   ANTHONY  LEE' })).to eq(true)
    end

    it 'parses a case with no bar' do
      fixture_path = 'spec/fixtures/parsers/attorney/no_bar.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.parse(parsed_html)

      expect(data[:attorneys].count).to eq 1
      expect(data[:attorneys].first[:bar_number].nil?).to eq true
    end

    it 'parses a case without an attorney' do
      fixture_path = 'spec/fixtures/parsers/attorney/none.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.new(parsed_html).parse

      expect(data[:attorneys]).to eq []
    end
  end
end
