RSpec.describe OscnScraper::Requestor::DistrictAttorney do
    describe '#perform' do
        it 'gets the html' do
          test = OscnScraper::Requestor::DistrictAttorney.new
          data = test.perform

          expect(data.class).to eq(HTTParty::Response)
        end
      end
  end
