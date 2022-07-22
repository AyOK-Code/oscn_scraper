require 'byebug'
RSpec.describe OscnScraper::Parsers::OkBar::AttorneyOkBar do
  it 'returns table from OkBar page' do
    fixture_path = 'spec/fixtures/ok_bar.html'
    parsed_html = load_and_parse_fixture(fixture_path)
    data = described_class.new(parsed_html).perform

    expect(data.first[:bar_number]).to eq '102'
    expect(data.first[:first_name]).to eq 'William'
    expect(data.first[:middle_name]).to eq 'Rogers'
    expect(data.first[:last_name]).to eq 'Abbott'
    expect(data.first[:city]).to eq 'Oklahoma City'
    expect(data.first[:state]).to eq 'OK'
    expect(data.first[:member_type]).to eq 'Senior Member'
    expect(data.first[:member_status]).to eq 'Good Standing'
    expect(data.first[:admit_date]).to eq '3/28/1961'
  end
end
