RSpec.describe OscnScraper::Parsers::Parties do
  it 'correctly parses the Party' do
    html = File.open('spec/fixtures/parsers/case_with_closed.html').read
    parsed_html = Nokogiri::HTML.parse(html)
    data = described_class.new(parsed_html).parse
    skip
  end
end
