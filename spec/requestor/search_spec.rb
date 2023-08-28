require 'spec_helper'

RSpec.describe OscnScraper::Requestor::Search do
  describe '#fetch_cases' do
    context 'when invalid params are passed' do
      it 'raises error' do
        params = {
          db: 'oklahoma',
          bad_param: Date.new(2020, 1, 1)
        }
        expect { described_class.new(params).fetch_cases }.to raise_error OscnScraper::Errors::InvalidParam
      end
    end
  end
end
