module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Judge
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def parse
        parse_judge
      end

      private

      attr_reader :parsed_html

      def parse_judge
        parent = parsed_html.at('td:contains("Judge:")')
        if parent.nil?
          { judge: nil }
        else
          element = parent.children.find { |d| d.text.include? "Judge:" }
          judge = element.text.gsub('Judge: ', '').strip
          { judge: judge }
        end
      end
    end
  end
end
