RSpec.describe OscnScraper::Parsers::Case do
  it 'correctly parses Closed On date' do
    fixture_path = 'spec/fixtures/parsers/case_with_closed.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html)

    expect(data[:closed_on]).to eq Date.new(2020, 6, 16)
  end
end
