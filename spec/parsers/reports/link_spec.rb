require 'byebug'

RSpec.describe OscnScraper::Parsers::Reports::Link do
  it 'correctly parses Closed On date' do
    fixture_path = '' # path to fixture
    html_doc = load_and_parse_fixture(fixture_path)
    data = described_class.parse(parsed_html)
    byebug
    # expect().to eq 'CF Docket E'
    # GOAL: Extract data from GetCaseInformation.asp?viewtype=&submitted=true&casemasterID=3946802&db=Oklahoma">CF-2021-489</A>
    # { oscn_id: 3946802, county: 'Oklahoma', case_number: 'CF-2021-489'}
  end
end
