RSpec.describe OscnScraper::Parsers::PartyAddress do
  require 'ostruct'
  it 'parses the parties' do
    fixture_path = 'spec/fixtures/parsers/parties/party_row.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    party_json = { id: 12, oscn_id: 7777 }
    party = OpenStruct.new(party_json)
    data = described_class.perform(parsed_html, party)

    expect(data).to include(
      {
        party_id: 12,
        record_on: Date.parse('20-02-2007'),
        status: 'Current',
        state: 'Oklahoma \\n',
        address_type: 'Home Address',
        zip: nil

      }
    )
  end
end
