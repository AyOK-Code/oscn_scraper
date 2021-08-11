RSpec.describe OscnScraper::Parsers::Judge do
  it 'correctly parses Closed On date' do
    fixture_path = 'spec/fixtures/parsers/case_with_judge.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html)

    expect(data[:judge]).to eq 'CF Docket E'
  end

  it 'distiguishes between a Docket and a Judge' do
    skip
  end
end
