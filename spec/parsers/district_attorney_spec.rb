RSpec.describe OscnScraper::Parsers::DistrictAttorney do
    describe '#perform' do
  it 'gets the html' do
    test_data = OscnScraper::Requestor::DistrictAttorney.new
    test_data = test_data.perform

    test_parser = described_class.new(test_data)

    parsed_html = test_parser.perform

    expect(parsed_html.class).to eq(Nokogiri::HTML4::Document)
    expect(parsed_html.css('tr td').first.children.text).to eq('District')
  end
end
  end
