require 'byebug'
require 'oscn_scraper'

# byebug
RSpec.describe OscnScraper::Parsers::Reports::Link do
  it 'correctly parses and gathers links' do
    fixture_path = 'spec/fixtures/parsers/reports/link.html'
    link_html = load_and_parse_fixture(fixture_path)
    data = described_class.parse(link_html)

    expect(data[:case_number]).to eq 'CF-2021-489'
    expect(data[:county]).to eq 'Oklahoma'
    expect(data[:oscn_id]).to eq 3_946_802
  end
end
