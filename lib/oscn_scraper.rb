# require 'oscn_scraper/version'
require 'nokogiri'
require 'httparty'
require 'byebug'

module OscnScraper
  # OSCN_CASE_URL = "https://www.oscn.net/dockets/GetCaseInformation.aspx"
  # OSCN_SEARCH_URL = "https://www.oscn.net/dockets/Results.aspx"
  # OSCN_PARTY_URL = "https://www.oscn.net/dockets/GetPartyRecord.aspx"
  # OSCN_DOCKET_URL ="https://www.oscn.net/applications/oscn/report.asp"
  class Error < StandardError; end
  class Cases
    def initialize; end

    def fetch_cases_for_day(date)
      county = "Oklahoma"
      base_url = "https://www.oscn.net/applications/oscn/report.asp?report=DailyFilings&errorcheck=true&database=&db=#{county}&StartDate=#{date}"

      data = HTTParty.get(base_url)
      parsed_data = Nokogiri::HTML(data)
      byebug
    end
  end
end

OscnScraper::Cases.new.fetch_cases_for_day('01/02/2020')
