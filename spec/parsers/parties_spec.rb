RSpec.describe OscnScraper::Parsers::Parties do
  it 'parses the parties' do
    html = File.open('spec/fixtures/parsers/parties/multiple.html').read
    parsed_html = Nokogiri::HTML.parse(html)
    data = described_class.new(parsed_html).parse

    expect(data[:parties].count).to eq 3
    expect(data[:parties]).to include(
      {
        name: 'PENA,  ANTHONY  RAMIRO',
        link: 'GetPartyRecord.aspx?db=oklahoma&cn=CF-2021-1511&id=18498184',
        party_type: 'Defendant'
      }
    )
  end
end
