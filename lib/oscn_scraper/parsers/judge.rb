module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Judge
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
        @judge = { judge: nil }
      end

      def parse
        parse_judge
      end

      private

      attr_accessor :judge

      def parse_judge
        parent = parsed_html.at('td:contains("Judge:")')
        return judge if parent.nil?

        element = parent.children.find { |d| d.text.include? 'Judge:' }
        judge[:judge] = element.text.gsub('Judge: ', '').strip
        judge
      end
    end
  end
end
