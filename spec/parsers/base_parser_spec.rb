RSpec.describe OscnScraper::Parsers::BaseParser do
  describe '#build_object' do
    it 'parses html' do
      # load fixture
      html = File.open('spec/fixtures/example.html').read
      # test against fixture
      data = described_class.new(html).build_object
      expect((data.css('title').text.include? 'OSCN Case Details')).to be true
    end
  end
end
