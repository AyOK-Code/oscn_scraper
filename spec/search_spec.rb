RSpec.describe OscnScraper::Search do
  describe '#fetch_cases' do
    it 'returns an error if no cases are found' do
      # load fixture
      skip
      html = File.open('spec/fixtures/example.html').read
      data = described_class.new(html).
      expect((data.css('title').text.include? 'OSCN Case Details')).to be true
    end

    it 'returns a warning if more than 500 cases are returned' do
      skip
    end

    it 'returns cases for the given search' do
      skip
    end
  end

  describe '#fetch_case_by_number' do
    it 'raises an error if missing county' do
      skip
    end

    it 'raises an error if missing case_number' do
      skip
    end

    it 'returns a valid page if params exist' do
      skip
    end
  end
end
