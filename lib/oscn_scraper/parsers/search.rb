module OscnScraper
  module Parsers
    # Parses search data from the case
    class Search
      attr_reader :search_html

      # Initializes class
      #
      # @param search_html [Html] Results page from search form
      # @return Class object
      def initialize(search_html, county = '')
        @search_html = search_html
        @links = []
        @county = county
      end

      # Class method to call .parse
      # @param search_html [Html]
      # @return searchs [Array]
      def self.parse(search_html, county = '')
        new(search_html, county).parse
      end

      def parse
        parse_search
      end

      private

      attr_accessor :links, :county

      def parse_search
        return links if search_html.blank?

        links = search_html.css('tr td').css('a').map { |l| OscnScraper::Parsers::Link.new(l).parse }
        links = remove_duplicates(links)
        links = filter_by_county(links) if county.present?
        links
      end

      def remove_duplicates(link_data)
        link_data.uniq { |l| [l[:oscn_id], l[:county]] }
      end

      def filter_by_county(link_data)
        link_data.filter { |l| l[:county] == county }
      end
    end
  end
end
