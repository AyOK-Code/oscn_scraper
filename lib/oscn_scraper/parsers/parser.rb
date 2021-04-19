require 'nokogiri'
require 'byebug'

module OscnScraper
  module Parsers
    # Description/Explanation of Parser class
    class Parser < BaseParser
      attr_reader :scraper

      def initialize(**kwargs)
        @scraper = OscnScraper::BaseScraper.new(**kwargs)
      end

      def parse_case_list(**kwargs)
        html = scraper.fetch_cases
        parsed_html = parse_html(html)
      end

      def parse_case
        html = scraper.fetch_case_by_number
        parsed_html = parse_html(html)
        build_object(parsed_html)
      end

      def build_object(parsed_html)
        case_object = {}
        [
          OscnScraper::Parsers::Case.new(parsed_html, )
        ].each do |p|
          case_object.merge(p.parse)
        end
        case_object
      end

      private

      def parse_html(html)
        Nokogiri::HTML(html)
      end
    end
  end
end
