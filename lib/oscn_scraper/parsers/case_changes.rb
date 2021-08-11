module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class CaseChanges
      include OscnScraper::Parsers::Helpers
      attr_reader :report_html

      def initialize(report_html)
        @report_html = report_html
        @cases = []
      end

      def parse
        report_html.css('a')
          .select { |a| a["href"].include?('GetCaseInformation.asp') }
      end
    end
  end
end
