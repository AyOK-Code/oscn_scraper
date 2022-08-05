RSpec.describe OscnScraper::Parsers::DistrictAttorney do
    describe '#perform' do
      it 'gets the html' do
        fixture_path = 'spec/fixtures/parsers/district_attorney.html'
        html = File.open(fixture_path).read

        parser = described_class.new(html)

        data = parser.perform

        expect(data.first[:district]).to eq('1')
        expect(data.first[:district_attorney]).to eq('George Leach')
        expect(data.first[:counties].size).to eq(4)
        expect(data.size).to eq(27)
      end
    end
  end
