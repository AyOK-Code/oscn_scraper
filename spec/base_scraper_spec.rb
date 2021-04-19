RSpec.describe OscnScraper::BaseScraper do
  describe '#fetch_cases_for_day' do
  end

  describe '#fetch_case_by_number(case_number)' do
    it 'returns data for a case' do
      data = described_class.new.fetch_cases_by_type_for_year(2020)
      byebug
    end
  end

  describe '#fetch_cases_by_type_for_year(year, type)' do
    it 'does great things' do

    end
  end
end
