require 'httparty'
require 'byebug'
require 'ruby-limiter'
require 'active_support/core_ext/object'
require 'logger'

module OscnScraper
  # Description/Explanation of BaseScraper class
  class BaseScraper
    extend Limiter::Mixin
    attr_accessor :logger, :queue

    def initialize(_kwargs = {})
      @queue = Limiter::RateQueue.new(120, interval: 60) # Limits requests to 120 per 60 seconds change to config
      @logger = Logger.new($stdout)
    end

    def fetch_daily_filings(date)
      endpoint = 'applications/oscn/report.asp?'
      params = {
        report: 'DailyFilings',
        errorcheck: true,
        db: 'Oklahoma',
        StartDate: date
      }
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    def events_scheduled(county, case_type_id, date)
      endpoint = 'applications/oscn/report.asp?'
      params = {
          errorcheck: true,
          db: county,
          CaseTypeID: case_type_id.to_s,
          StartDate: date,
          GeneralNumber: 1,
          generalnumber1: 1,
          report: 'WebJudicialDocketCaseTypeAll'
        }
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    private

    def request(url)
      # @queue.shift
      sleep rand(2)
      HTTParty.get(url)
    end

    def params
      {
        db: county,
        number: number,
        lname: last_name,
        fname: first_name,
        mname: middle_name,
        DoBMin: dob_min,
        DoBMax: dob_max,
        partytype: party_type,
        apct: appellate_case_type,
        dcct: district_case_type,
        FiledDateL: filed_after,
        FiledDateH: filed_before,
        ClosedDateL: closed_after,
        ClosedDateH: closed_before,
        iLC: app_only_court,
        iLCType: app_only_case_type,
        iYear: app_only_filing_year,
        iNumber: app_only_number,
        citation: citation
      }
    end

    def valid_param?
      # TODO: Finish method
      params.keys
    end

    def base_url
      'https://www.oscn.net/'
    end
  end
end
