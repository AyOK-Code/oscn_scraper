require 'byebug'
require 'oscn_scraper'

# byebug
RSpec.describe OscnScraper::Parsers::Reports::Link do
  it 'correctly parses and gathers links' do
    fixture_path = '/Users/jwilliams/Desktop/code/oscn_scraper/spec/fixtures/parsers/reports/daily_fillings_report.html'
    html_doc = load_and_parse_fixture(fixture_path)
    data = []
    html_doc.css('td a').each do |a|
      data << described_class.parse(a)
    end

    expect(data.size).to eq 1
    expect(data.first[:case_number]).to eq 'CF-2021-489'
    expect(data.first[:county]).to eq 'Oklahoma'
    expect(data.first[:oscn_id]).to eq '3946802'
  end
end
