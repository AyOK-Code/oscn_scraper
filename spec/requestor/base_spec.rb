require 'spec_helper'
require 'byebug'

RSpec.describe OscnScraper::Requestor::Base do
  it '#concatenated_url(endpoint, params = {})' do
    url = described_class.new.concatenated_url('endpoint')

    expect(url).to eq 'https://www.oscn.net/endpoint'
  end

  describe '#request' do
    it 'raises the captcha error' do
      request_url = 'https://www.oscn.net/endpoint' # can I evem use this since this is the base class?
      response_body = File.read('spec/fixtures/captcha.html')
      stub_request(:get, request_url)
        .to_return(status: 200, body: response_body, headers: {})

      expect { described_class.new.send('request', request_url) }.to raise_error OscnScraper::Errors::Captcha
    end
  end
end
