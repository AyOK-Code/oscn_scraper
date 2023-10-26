RSpec.describe OscnScraper::Parsers::Parties do
  it 'parses the parties' do
    fixture_path = 'spec/fixtures/parsers/parties/multiple.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html)

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
