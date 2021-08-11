require 'awesome_print'

RSpec.describe OscnScraper::Parsers::Case do
  it 'correctly parses filed on date' do
    fixture_path = 'spec/fixtures/parsers/case/case_with_closed.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html.children.css('td'))

    expect(data[:filed_on]).to eq Date.new(2018, 3, 16)
  end

  it 'returns nil if case is not closed' do
    fixture_path = 'spec/fixtures/parsers/case/case_not_closed.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html.children.css('td'))

    expect(data[:closed_on]).to eq nil
  end

  it 'correctly parses closed on date' do
    fixture_path = 'spec/fixtures/parsers/case/case_with_closed.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html.children.css('td'))

    expect(data[:closed_on]).to eq Date.new(2020, 6, 16)
  end
end
