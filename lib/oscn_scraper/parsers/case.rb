module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Case
      include OscnScraper::Parsers::Helpers
      attr_reader :parsed_html, :case_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
        @case_html = parsed_html.at('td:contains("Closed:")')
        @case_data = { closed_on: nil }
      end

      def parse
        parse_closed_date
      end

      private

      attr_accessor :case_data

      def parse_closed_date
        return case_data if case_html.blank?

        element = case_html.children.find { |d| d.text.include? 'Closed:' }
        date = element.text.gsub('Closed: ', '')
        { closed_on: parse_date(date) }
      end
    end
  end
end
