RSpec.describe OscnScraper::Parsers::Attorney do
  describe '#parse' do
    it 'parses a case with multiple' do
      html = File.open('spec/fixtures/parsers/attorney/multiple.html').read
      Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that all data is there
    end

    it 'parses a case with no bar' do
      html = File.open('spec/fixtures/parsers/attorney/multiple.html').read
      Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that script does not break
      # Test that script bar number is nil
    end

    it 'parses a case without an attorney' do
      html = File.open('spec/fixtures/parsers/attorney/none.html').read
      Nokogiri::HTML.parse(html)
      expect(false).to eq true
      # Test that empty array is returned
    end
  end
end
