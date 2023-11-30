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
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/no_alias.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:aliases_column][1].text).to eq 'None Found.'
    end
  end

  context 'when party has aliases' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:aliases_column][1].text).to eq 'EAGLE, AKA MARLENE ANNETTE '
      expect(data[:aliases_column][3].text).to eq 'ROBINSON, AKA ANNETTE '
    end
  end

  context 'when party has marital status' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias_married.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][1].text).to eq 'True'
    end
  end

  context 'when party has no marital status' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][1].text).to eq '-'
    end
  end

  context 'when party has birth month and year' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][2].text).to eq '05/1984'
    end
  end

  context 'when party has no birth month and year' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias_married.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][2].text).to eq '-'
    end
  end

  context 'when party has birth city' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias_married.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][3].text).to eq 'Tulsa'
    end
  end

  context 'when party has no birth city' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][3].text).to eq '-'
    end
  end

  context 'when party has birth place' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias_married.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][4].text).to include 'Oklahoma'
    end
  end

  context 'when party has no birth place' do
    it 'parses the party' do
      fixture_path = 'spec/fixtures/parsers/parties/party_example_alias.html'

      parsed_html = load_and_parse_fixture(fixture_path)
      data = described_class.perform(parsed_html)
      expect(data[:personal_columns][4].text).to include '-'
    end
  end
end
