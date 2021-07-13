module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Attorney
      attr_reader :attorney_html

      def initialize(attorney_html)
        @attorney_html = attorney_html
        @attorneys = { attorneys: [] }
      end

      def self.parse(attorney_html)
        new(attorney_html).parse
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
          name = parse_name(column_one)
          bar_number = parse_bar_number(column_one)
          address = parse_address(a)
          all_parties = a.css('td')[1].children.select { |e| e.node_name == 'text' }
          attorneys[:attorneys] << {
            name: name,
            address: address,
            bar_number: bar_number,
            represented_parties: all_parties.map { |e| parse_parties(e) }
          }
        end
        attorneys
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

      def parse_address(attorney)
        attorney.css('td')[0].children[1..].inner_html
      end

      def parse_parties(element)
        element.text
      end
    end
  end
end
