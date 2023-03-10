module OscnScraper
  module Parsers
    # Parses search data from the case
    class Search
      attr_reader :search_html

      # Initializes class
      #
      # @param search_html [Html] Results page from search form
      # @return Class object
      def initialize(search_html, county='')
        @search_html = search_html
        @links = []
      end

      # Class method to call .parse
      # @param search_html [Html]
      # @return searchs [Array]
      def self.parse(search_html)
        new(search_html).parse
      end

      # TODO: Drop this method?
      def parse
        parse_search
      end

      private

      attr_accessor :links

      def parse_search
        return links if search_html.blank?

        search_html.css('tbody tr').each do |a|
          column_one = a.css('td')[0].children[0].text
          name = parse_name(column_one)
          bar_number = parse_bar_number(column_one)
          address = parse_address(a)
          all_parties = a.css('td')[1].children.select { |e| e.node_name == 'text' }
          searchs[:searchs] << {
            name: name,
            address: address,
            bar_number: bar_number,
            represented_parties: all_parties.map { |e| parse_parties(e) }
          }
        end
        searchs
      end

      def parse_name(text)
        text.split('(')[0].squish
      end

      def parse_bar_number(text)
        # TODO: Change to regex
        text.split('(')[1].split('#')[1].gsub(')', '')
      rescue NoMethodError
        # TODO: Log unparsible bar number
      end

      def parse_address(search)
        search.css('td')[0].children[1..].inner_html
      end

      def parse_parties(element)
        element.text
      end
    end
  end
end
