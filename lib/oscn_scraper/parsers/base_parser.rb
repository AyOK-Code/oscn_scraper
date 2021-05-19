require 'nokogiri'
require 'byebug'

module OscnScraper
  module Parsers
    # Builds the objects by parsing the page
    class BaseParser
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def build_object
        case_object = {}
        [
          OscnScraper::Parsers::Case.new(case_html),
          OscnScraper::Parsers::Judge.new(judge_html),
          OscnScraper::Parsers::Attorney.new(attorney_html),
          OscnScraper::Parsers::Parties.new(parties_html),
          OscnScraper::Parsers::Events.new(events_html),
          OscnScraper::Parsers::Counts.new(counts_html),
          OscnScraper::Parsers::DocketEvents.new(docket_events_html)
        ].each do |p|
          data = p.parse
          case_object.merge!(data)
        end
        case_object
      end

      private

      def parse_html(html)
        Nokogiri::HTML(html.body)
      end

      def case_html
        parsed_html.at('td:contains("Closed:")')
      end

      def judge_html
        parsed_html.at('td:contains("Judge:")')
      end

      def attorney_html
        parsed_html.xpath('//h2[contains(@class, "attorneys")]/following-sibling::*[1]')
      end

      def parties_html
        parsed_html.xpath('//h2[contains(@class, "party")]/following-sibling::p[1]')
      end

      def events_html
        parsed_html.xpath('//h2[contains(@class, "events")]/following-sibling::*[1]')
      end

      def counts_html
        parsed_html.css('div.CountsContainer')
      end

      def docket_events_html
        parsed_html.xpath('//h2[contains(@class, "docket")]/following-sibling::*[1]')
      end
    end
  end
end
