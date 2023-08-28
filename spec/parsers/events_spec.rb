RSpec.describe OscnScraper::Parsers::Events do
  describe '#parse' do
    it 'parses a case with many events' do
      fixture_path = 'spec/fixtures/parsers/events/multiple.html'
      html_doc = load_and_parse_fixture(fixture_path)
      parsed_html = html_doc.css('table')
      data = described_class.parse(parsed_html)

      expect(data[:events].count).to eq 24
      expect(data[:events].first).to include({ date: DateTime.new(2020, 5, 29, 9, 1, 0o0, '-0600'),
                                               event_type: 'NO ISSUE PRELIMINARY HEARING',
                                               event_code: 'PDP',
                                               party_name: 'COHEN,  JOHN  DAVID',
                                               docket: 'Preliminary Hearing Docket' })
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
