module OscnScraper
  module Requestor
    # get html of District Attorney page
    class DistrictAttorney < Base
        
      def initialize
        super
        @url = 'https://www.ok.gov/dac/District__Attorneys/index.html'
      end

      def perform
        request(@url)
      end
    end
  end
end
