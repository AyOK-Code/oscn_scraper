RSpec.describe OscnScraper::Parsers::Case do
  it 'correctly parses filed on date' do
    fixture_path = 'spec/fixtures/parsers/case/case_with_closed.html'
    html_doc = load_and_parse_fixture(fixture_path)
    parsed_html = html_doc.children.css('td')
    data = described_class.parse(parsed_html)

    expect(data[:filed_on]).to eq Date.new(2018, 3, 16)
  end

  it 'returns nil if case is not closed' do
    fixture_path = 'spec/fixtures/parsers/case/case_not_closed.html'
    html_doc = load_and_parse_fixture(fixture_path)
    parsed_html = html_doc.children.css('td')
    data = described_class.parse(parsed_html)

    expect(data[:closed_on]).to eq nil
  end

  it 'correctly parses closed on date' do
    fixture_path = 'spec/fixtures/parsers/case/case_with_closed.html'
    html_doc = load_and_parse_fixture(fixture_path)
    parsed_html = html_doc.children.css('td')
    data = described_class.parse(parsed_html)

    expect(data[:closed_on]).to eq Date.new(2020, 6, 16)
  end
end
