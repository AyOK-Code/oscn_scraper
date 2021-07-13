module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Case
      include OscnScraper::Parsers::Helpers
      attr_reader :case_html

      def initialize(case_html)
        @case_html = case_html
        @case_data = { closed_on: nil }
      end

      def self.parse(case_html)
        new(case_html).parse
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
