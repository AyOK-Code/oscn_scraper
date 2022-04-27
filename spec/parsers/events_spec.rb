RSpec.describe OscnScraper::Parsers::Events do
  describe '#parse' do
    it 'parses a case with many events' do
      fixture_path = 'spec/fixtures/parsers/events/multiple.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('table')
      data = described_class.parse(parsed_html)

      expect(data[:events].count).to eq 13
      expect(data[:events].first).to include({ date: DateTime.new(2017, 4, 6, 13, 30, 0o0, '-0600'),
                                               event_type: 'PRELIMINARY HEARING CONFERENCE',
                                               event_code: 'PRELIMC',
                                               party_name: 'CARGLE,  EDWARD  III',
                                               docket: 'Larry Shaw' })
    end

    it 'parses a case with no events' do
      fixture_path = 'spec/fixtures/parsers/events/none.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('table')
      data = described_class.parse(parsed_html)

      expect(data[:events].count).to eq 0
    end
  end
end
