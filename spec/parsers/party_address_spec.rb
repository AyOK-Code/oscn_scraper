# require 'ostruct'
#   it 'parses the parties' do
#     fixture_path = 'spec/fixtures/parsers/parties/party_row.html'
#     parsed_html = load_and_parse_fixture(fixture_path)
#     party_json = { id: 12, oscn_id: 7777 }
#     party = OpenStruct.new(party_json)
#     data = described_class.perform(parsed_html, party)

#     expect(data).to include(
#       {
#         party_id: 12,
#         record_on: Date.parse('20-02-2007'),
#         status: 'Current',
#         state: 'Oklahoma \\n',
#         address_type: 'Home Address',
#         zip: nil

#       }
#     )
#   end
# end

RSpec.describe OscnScraper::Parsers::PartyAddress do
  context 'when only the state is provided' do
    it 'parses the party address' do
      fixture_path = 'spec/fixtures/parsers/parties/party_row.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      party_json = { id: 12, oscn_id: 7777 }
      data = described_class.perform(parsed_html, party_json)
      expect(data).to include({ record_on: Date.parse('20-02-2007'), status: 'Current', city: nil,
                                state: 'Oklahoma \\n', zip: nil, address_type: 'Home Address' })

      # Save the fixture with only the stat
      # TODO: test that the state is saved & the rest is nil
    end
  end

  context 'when city, state, and zip are provided' do
    it 'parses the party address' do
      fixture_path = 'spec/fixtures/parsers/parties/party_row_no_street.html'
      parsed_html = load_and_parse_fixture(fixture_path)
      party_json = { id: 12, oscn_id: 7777 }
      data = described_class.perform(parsed_html, party_json)
      expect(data).to include({ record_on: Date.parse('20-02-2007'), status: 'Current', city: 'NORMAN',
                                state: 'Oklahoma', zip: 73_069, address_type: 'Home Address' })
    end
  end

  context 'when no records found' do
    it 'returns an empty array' do
      fixture_path = 'spec/fixtures/parsers/parties/party_row_no_record.html'
      # Save fixture: https://www.oscn.net/dockets/GetPartyRecord.aspx?db=oklahoma&cn=CF-2020-126&id=16116794
      parsed_html = load_and_parse_fixture(fixture_path)
      party_json = { id: 12, oscn_id: 7777 }
      data = described_class.perform(parsed_html, party_json)
      expect(data).to be nil
    end
  end
end
