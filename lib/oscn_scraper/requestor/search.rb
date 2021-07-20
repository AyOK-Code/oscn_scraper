module OscnScraper
  module Requestor
    # Uses parameters to search OSCN
    class Search < Base
      attr_reader :kwargs

      def new(kwargs = {})
        @kwargs = kwargs
        valid_params?(kwargs)
      end

      def self.fetch_cases(kwargs = {})
        new(kwargs).fetch_cases
      end

      def self.fetch_case_by_number(kwargs = {})
        new(kwargs).fetch_case_by_number
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
      def fetch_case_by_number
        endpoint = 'dockets/GetCaseInformation.aspx?'
        params = {
          db: kwargs[:county].downcase,
          number: kwargs[:case_number]
        }
        url = "#{base_url}#{endpoint}#{params.to_query}"
        request(url)
      end
    end
  end
end
