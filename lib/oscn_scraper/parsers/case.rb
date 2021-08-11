module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Case
      include OscnScraper::Parsers::Helpers
      attr_reader :case_html

      def initialize(case_html)
        @case_html = case_html
        @case_data = { filed_on: nil, closed_on: nil }
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

        closed_element = case_html.children.find { |d| d.text.include? 'Closed:' }
        closed_on = closed_element.nil? ? nil : closed_element.text.gsub('Closed: ', '')
        filed_element = case_html.children.find { |d| d.text.include? 'Filed:' }
        filed_on =  filed_element.nil? ? nil : filed_element.text.gsub('Filed: ', '').squish

        { filed_on: parse_date(filed_on), closed_on: parse_date(closed_on) }
      end
    end
  end
end
