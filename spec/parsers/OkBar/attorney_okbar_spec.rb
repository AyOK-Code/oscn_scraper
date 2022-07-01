require 'byebug'
RSpec.describe OscnScraper::Parsers::OkBar::AttorneyOkBar do
  it 'returns table from OkBar page' do
    data = described_class.new('OK').perform

    expect(data.attribute('class').value).to include('gv-table-view')
    expect(data.css('td')[0].children.text).to eq '102'
    expect(data.css('td')[1].children.text).to eq 'William'
    expect(data.css('td')[2].children.text).to eq 'Rogers'
    expect(data.css('td')[3].children.text).to eq 'Abbott'
    expect(data.css('td')[4].children.text).to eq 'Oklahoma City'
    expect(data.css('td')[5].children.text).to eq 'OK'
    expect(data.css('td')[6].children.text).to eq 'Senior Member'
    expect(data.css('td')[7].children.text).to eq 'Good Standing'
    expect(data.css('td')[8].children.text).to eq '3/28/1961'
  end
end
