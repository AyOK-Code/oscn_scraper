RSpec.describe OscnScraper::Parsers::Counts do
  describe '#parse' do
    it 'parses a case with multiple counts' do
      html = File.open('spec/fixtures/parsers/counts/multiple.html').read
      parsed_html = Nokogiri::HTML.parse(html)
      data = described_class.new(parsed_html).parse
      expect(false).to eq true
      # Test that all data is there
    end

    it 'parses a single count' do
      html = File.open('spec/fixtures/parsers/counts/single.html').read
      parsed_html = Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that script does not break
      # Test that script bar number is nil
    end

    it 'parses a counts without disposition info' do
      html = File.open('spec/fixtures/parsers/counts/no_disposition.html').read
      parsed_html = Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that script does not break
      # Test that script bar number is nil
    end

    it 'skips counts that do not have parties attached' do

    end
  end
end
