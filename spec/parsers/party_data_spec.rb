# it 'parses the party' do
#     fixture_path = 'spec/fixtures/parsers/parties/party_example.html'

#     parsed_html = load_and_parse_fixture(fixture_path)
#     data = described_class.perform(parsed_html)

#     expect(data[:personal_columns].count).to eq 5
#     expect(data[:personal_columns][0].to_html).to eq '<td>06/18/2019</td>' # Don't send back html
#     expect(data[:aliases_column][1].to_html).to eq 'EAGLE, AKA MARLENE ANNETTE '
#     expect(data[:address_row][1].children[7].to_html).to include('73159')
# end

RSpec.describe OscnScraper::Parsers::PartyData do
  context 'when party has no aliases' do
    # TODO: 
  end

  context 'when party has aliases' do

    # TODO: 
  end

  context 'when party has marital status' do
    # TODO: 

  end

  context 'when party has no marital status' do
    # TODO: 

  end

  context 'when party has birth month and year' do
    # TODO: 

  end

  context 'when party has no birth month and year' do
    # TODO: 

  end

  context 'when party has birth city' do
    # TODO: 
  
  end

  context 'when party has no birth city' do
    # TODO: 

  end

  context 'when party has birth place' do
    # TODO: 

  end

  context 'when party has no birth place' do
    # TODO: 

  end
end
