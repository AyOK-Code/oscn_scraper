RSpec.describe OscnScraper::Parsers::Judge do
  it 'correctly parses Closed On date' do
    html = File.open('spec/fixtures/parsers/case_with_judge.html').read
    parsed_html = Nokogiri::HTML.parse(html)
    data = described_class.new(parsed_html).parse

    expect(data).to eq 'CF Docket E'
  end

  it 'distiguishes between a Docket and a Judge' do
    skip
  end
end
