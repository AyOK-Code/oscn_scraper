module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Case
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def parse
        parse_closed_date
      end

      private

      attr_reader :parsed_html

      def parse_closed_date
        parent = parsed_html.at('td:contains("Closed:")')
        if parent.nil?
          {closed_on: nil}
          # put in logs that case is active
        else
          element = parent.children.find { |d| d.text.include? "Closed:" }
          date = element.text.gsub('Closed: ', '')
          closed_on = Date.strptime(date, '%m/%d/%Y')
          {closed_on: closed_on}
        end
      end

      def parse_case_number

      end

      def parse_oscn_id

      end
    end
  end
end
