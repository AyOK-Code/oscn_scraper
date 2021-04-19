require 'httparty'
require 'byebug'
require 'ruby-limiter'
require 'active_support/core_ext/object'
require 'logger'

module OscnScraper
  # Description/Explanation of BaseScraper class
  class BaseScraper
    extend Limiter::Mixin
    attr_accessor :county, :number, :last_name, :first_name,
    :middle_name, :dob_min, :dob_max, :party_type, :appellate_case_type,
    :district_case_type, :filed_after, :filed_before, :closed_after,
    :closed_before, :app_only_court, :app_only_case_type, :app_only_filing_year,
    :app_only_number, :citation, :logger, :queue

    def initialize(**kwargs)
      @county = kwargs[:county] # County or Court
      @number = kwargs[:number] # Case Number
      @last_name = kwargs[:last_name] # Last Name
      @first_name = kwargs[:first_name] # First Name
      @middle_name = kwargs[:middle_name] # Middle Name
      @dob_min = kwargs[:dob_min] # Born On or After
      @dob_max = kwargs[:dob_max] # Born Before Date
      @party_type = kwargs[:party_type] # Part Type
      @appellate_case_type = kwargs[:appellate_case_type] # Appellate Court Case Type
      @district_case_type = kwargs[:district_case_type] # District Court Case Type
      @filed_after = kwargs[:filed_after] # Filed After
      @filed_before = kwargs[:filed_before] # Filed Before
      @closed_after = kwargs[:closed_after] # Closed After
      @closed_before = kwargs[:closed_before] # Closed Before
      @app_only_court = kwargs[:app_only_court] # Appellate Only Court
      @app_only_case_type = kwargs[:app_only_case_type] # Appellate Only Case Type
      @app_only_filing_year = kwargs[:app_only_filing_year] # Appellate Only Filing Year
      @app_only_number = kwargs[:app_only_number] # Appellate Only Number
      @citation = kwargs[:citation] # Traffic Citation
      @queue = Limiter::RateQueue.new(120, interval: 60) # Limits requests to 120 per 60 seconds change to config
      @logger = Logger.new(STDOUT)
    end

    def fetch_cases_for_day(date)
      endpoint = '/applications/oscn/report.asp?report=DailyFilings&errorcheck=true&'
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    def fetch_cases
      endpoint = '/dockets/Results.aspx?'
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    def fetch_case_by_number
      endpoint = 'dockets/GetCaseInformation.aspx?'
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
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
      data = request(url)
    end

    def fetch_party
      endpoint = 'dockets/GetPartyRecord.aspx?'
      params = {
        db: 'tulsa',
        cn: 'CF-2021-1643',
        id: 18497793
      }
      url = "#{base_url}#{endpoint}#{params.to_query}"
      data = request(url)
    end

    private

    def request(url)
      @queue.shift

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
        citation: citation,
      }
    end

    def base_url
      'https://www.oscn.net/'
    end
  end
end
