require 'spec_helper'

RSpec.describe OscnScraper::Requestor::DistrictAttorney do
    describe '#perform' do
        it 'gets the html' do
          request_url = "https://www.ok.gov/dac/District__Attorneys/index.html"
          response_body = "test response"
          stub_request(:get, request_url)
            .to_return(status: 200, body: response_body, headers: {})
         result_response = described_class.new.perform
          expect(result_response.body).to eq response_body
      end
  end
end
