module OscnScraper
  module Parsers
    # Parses da_html with Nokogiri and returns it
    class DistrictAttorney
      def initialize(html)
        @da_html = html
      end

      def perform
        Nokogiri::HTML(@da_html)
      end
    end
  end
end
