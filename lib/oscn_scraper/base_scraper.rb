require 'httparty'
require 'byebug'

module OscnScraper
  # Description/Explanation of BaseScraper class
  class BaseScraper
    extend Limiter::Mixin
    attr_accessor :queue

    def initialize(county: 'Oklahoma')
      @county = county
      # db= County or Court
      # number= Case Number
      # lname= Last Name
      # fname= First Name
      # mname= Middle Name
      # DoBMin= Born On or After
      # DoBMax= Born Before Date
      # partytype= Part Type
      # apct= Appellate Court Case Type
      # dcct= District Court Case Type
      # FiledDateL= Filed After
      # FiledDateH= Filed Before
      # ClosedDateL= Closed After
      # ClosedDateH= Closed Before
      # iLC= Appellate Only Court
      # iLCType= Appellate Only Case Type
      # iYear= Appellate Only Filing Year
      # iNumber= Appellate Only Number
      # citation= Traffic Citation
      # Limits requests to 100 per minute change to config
      @queue = Limiter::RateQueue.new(100, interval: 60)
    end

    def fetch_cases_for_day(date)
      county = 'Oklahoma'
      base_url = "https://www.oscn.net/applications/oscn/report.asp?report=DailyFilings&errorcheck=true&database=&db=#{county}&StartDate=#{date}"
      request(base_url)
    end

    def fetch_case_by_number(_case_number)
      url = "#{base_url}dockets/GetCaseInformation.aspx"
      params = {
        db: 'oklahoma',
        number: 'CF-2020-6140'
      }
      # request(base_url)
    end

    def fetch_case_by_id(case_number)
      # TODO: Hit endpoint
      # request(base_url)
    end

    def fetch_cases_by_type_for_year(_year)
      url = "#{base_url}applications/oscn/report.asp"
      params = {
        report: 'DailyFilings',
        errorcheck: true,
        db: 'Oklahoma',
        StartDate: '12/31/2020'
      }
      # TODO: this could use the ending date to figure out how many cases there are
      # request(base_url)
    end

    private

    def request(url)
      queue.shift # Blocks if limit met

      HTTParty.get(url)
    end

    def params
      # TODO: Leverage Active support Object.to_query
    end

    def base_url
      'https://www.oscn.net/'
    end
  end
end
