module OscnScraper
  # Party Scraper
  class Party < OscnScraper::BaseScraper
    attr_accessor :county, :oscn_id

    def initialize
      super
      @county = kwargs[:county] # County or Court
      @oscn_id = kwargs[:oscn_id]
    end

    def fetch_party
      raise_if_missing_params!
      endpoint = 'dockets/GetPartyRecord.aspx?'
      params = {
        db: county,
        id: oscn_id
      }
      url = "#{base_url}#{endpoint}#{params.to_query}"
      request(url)
    end

    private

    # TODO: Refactor to parent class
    def raise_if_missing_params!
      raise OscnScraper::MissingParamsError, 'missing required param: county' if county.blank?
      raise OscnScraper::MissingParamsError, 'missing required param: oscn_id' if oscn_id.blank?
    end
  end
end
