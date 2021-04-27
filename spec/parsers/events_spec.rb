RSpec.describe OscnScraper::Parsers::Events do
  it 'correctly parses the Event' do
    html = File.open('spec/fixtures/parsers/case_with_closed.html').read
    parsed_html = Nokogiri::HTML.parse(html)
    described_class.new(parsed_html).parse
    skip
  end

  it 'returns a empty array if the next sibling is not a table' do
    skip
  end
end
