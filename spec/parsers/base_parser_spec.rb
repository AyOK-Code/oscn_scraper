RSpec.describe OscnScraper::Parsers::BaseParser do
  describe '#build_object' do
    it 'parses html' do
      # load fixture
      html = File.open('spec/fixtures/example.html').read
      # test against fixture
      parsed_html = Nokogiri::HTML.parse(html)

      described_class.new(parsed_html).build_object
      expect(true).to eq false
    end
  end
end
