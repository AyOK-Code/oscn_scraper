RSpec.describe OscnScraper::Parsers::Case do
  it 'correctly parses Closed On date' do
    html = File.open('spec/fixtures/parsers/case_with_closed.html').read
    parsed_html = Nokogiri::HTML.parse(html)
    data = described_class.new(parsed_html).parse

    expect(data[:closed_on]).to eq Date.new(2020, 6, 16)
  end
end
