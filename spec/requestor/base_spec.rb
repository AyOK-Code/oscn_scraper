require 'spec_helper'

RSpec.describe OscnScraper::Requestor::Base do
  it '#concatenated_url(endpoint, params = {})' do
    url = described_class.new.concatenated_url('endpoint')

    expect(url).to eq 'https://www.oscn.net/endpoint'
  end
end
