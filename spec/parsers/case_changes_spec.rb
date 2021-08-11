require 'awesome_print'

RSpec.describe OscnScraper::Parsers::CaseChanges do
  it 'returns an empty array if no cases are on the page' do
    fixture_path = 'spec/fixtures/parsers/case_changes/blank_docket_schedule.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.new(parsed_html).parse

    expect(data.count).to eq 0
  end

  it 'returns an array of case numbers' do
    fixture_path = 'spec/fixtures/parsers/case_changes/case_changes.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.new(parsed_html).parse

    expect(data.count).to eq 11
    expect(data.map { |d| d['href'] }).to include 'GetCaseInformation.asp?submitted=true&db=Oklahoma&casemasterid=2829347'
  end
end
