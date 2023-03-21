RSpec.describe OscnScraper::Parsers::Link do
  it 'correctly parses and gathers links' do
    fixture_path = 'spec/fixtures/parsers/links/link.html'
    link_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(link_html.at('a'))

    expect(data[:case_number]).to eq 'CF-2021-489'
    expect(data[:link]).to eq 'GetCaseInformation.asp?viewtype=&submitted=true&casemasterID=3946802&db=Oklahoma'
    expect(data[:county]).to eq 'Oklahoma'
    expect(data[:oscn_id]).to eq 3_946_802
  end

  context 'when extracting oscn_id' do
    context 'when link has cmid params' do
      it 'correctly extracts data' do
        fixture_path = 'spec/fixtures/parsers/links/search_link.html'
        link_html = load_and_parse_fixture(fixture_path)
        data = described_class.parse(link_html.at('a'))

        expect(data[:case_number]).to eq 'CF-2020-00123'
      end
    end
  end

  context 'when extracting the case number' do
    context 'when link is name of case' do
      it 'extracts the case number' do
        fixture_path = 'spec/fixtures/parsers/links/case_name_link.html'
        link_html = load_and_parse_fixture(fixture_path)
        data = described_class.parse(link_html.at('a'))

        expect(data[:case_number]).to eq 'CF-2020-123'
      end
    end

    context 'when case number is only in the text' do
      it 'extracts the case number' do
        fixture_path = 'spec/fixtures/parsers/links/link.html'
        link_html = load_and_parse_fixture(fixture_path)
        data = described_class.parse(link_html.at('a'))

        expect(data[:case_number]).to eq 'CF-2021-489' 
      end
    end
  end

  

  context 'when link is missing params' do
    context 'when casemasterID is present' do
      it 'raises an error' do
        fixture_path = 'spec/fixtures/parsers/links/missing_param_casemaster.html'
        link_html = load_and_parse_fixture(fixture_path)

        expect { 
          described_class.parse(link_html.at('a')) 
        }.to raise_error OscnScraper::Errors::RequiredParam
      end
    end

    context 'when link is from search' do
      it 'raises an error' do
        fixture_path = 'spec/fixtures/parsers/links/missing_param.html'
        link_html = load_and_parse_fixture(fixture_path)

        expect { 
          described_class.parse(link_html.at('a')) 
        }.to raise_error OscnScraper::Errors::RequiredParam
      end
    end
  end
end
