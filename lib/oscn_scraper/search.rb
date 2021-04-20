module OscnScraper
  class Search < BaseScraper
    attr_accessor :county, :number, :last_name, :first_name,
    :middle_name, :dob_min, :dob_max, :party_type, :appellate_case_type,
    :district_case_type, :filed_after, :filed_before, :closed_after,
    :closed_before, :app_only_court, :app_only_case_type, :app_only_filing_year,
    :app_only_number, :citation,

    def initialize(**kwargs)
      super
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
    end

    # Mimics the search funcitonality of site
    # https://www.oscn.net/dockets/Search.aspx
    def fetch_cases
      endpoint = '/dockets/Results.aspx?'
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    # Find a case by the Case number
    # County must be specific because Case Number is only unique scoped to county
    def fetch_case_by_number(county, case_number)
      raise_if_missing_params!
      endpoint = 'dockets/GetCaseInformation.aspx?'
      params = {
        county: county,
        case_number: case_number
      }
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    private

    attr_reader :county, :case_number

    # TODO: move to base class and make dynamic
    def raise_if_missing_params!
      raise OscnScraper::MissingParamsError, "missing required param: county" if county.blank?
      raise OscnScraper::MissingParamsError, "missing required param: case_number" if case_number.blank?
    end
  end
end
