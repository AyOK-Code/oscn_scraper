RSpec.describe OscnScraper::Parsers::Judge do
  it 'correctly parses Closed On date' do
    fixture_path = 'spec/fixtures/parsers/judge/case_with_judge.html'
    html_doc = load_and_parse_fixture(fixture_path)
    parsed_html = html_doc.css('td')
    data = described_class.parse(parsed_html)

    expect(data[:judge]).to eq 'CF Docket E'
  end
end
