module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Attorney
      attr_reader :attorney_html

      def initialize(attorney_html)
        @attorney_html = attorney_html
        @attorneys = { attorneys: [] }
      end

      def parse
        parse_attorney
      end

      private

      attr_accessor :attorneys

      def parse_attorney
        return attorneys if attorney_html.blank?

        attorney_html.css('tbody tr').each do |a|
          column_one = a.css('td')[0].children[0].text
          column_two = a.css('td')[1].children[0].text
          name = parse_name(column_one)
          bar_number = parse_bar_number(column_one)
          address = parse_address(a)
          parties = parse_parties(column_two)

          attorneys[:attorneys] << {
            name: name,
            address: address,
            bar_number: bar_number,
            represented_parties: parties
          }
        end
        attorneys
      end

      def parse_name(text)
        text.split('(')[0].squish
      end

      def parse_bar_number(text)
        text.split('(')[1].split('#')[1].gsub(')', '')
      rescue NoMethodError
        nil
      end

      def parse_address(attorney)
        attorney.css('td')[0].children[1..].inner_html
      end

      def parse_parties(text)
        text
      end
    end
  end
end
