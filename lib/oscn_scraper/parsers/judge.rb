module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Judge
      attr_reader :judge_html

      def initialize(judge_html)
        @judge_html = judge_html
        @judge = { judge: nil }
      end

      def parse
        parse_judge
      end

      private

      attr_accessor :judge

      def parse_judge
        return judge if judge_html.nil?

        element = judge_html.children.find { |d| d.text.include? 'Judge:' }
        judge[:judge] = element.text.gsub('Judge: ', '').strip
        judge
      end
    end
  end
end
