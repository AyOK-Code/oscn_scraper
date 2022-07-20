require 'byebug'
module OscnScraper
  module Parsers
    # Parses da_html with Nokogiri and returns it
    class DistrictAttorney
      attr_reader :parsed_html
      attr_accessor :district_attorneys

      def initialize(html)
        @parsed_html = Nokogiri::HTML(html)

        @district_attorneys = []
      end

      def perform
        parsed_html.css('tr').each_with_index do |d, i|
          next if i.zero?

          district_attorneys << district_attorney(d)
        end

        district_attorneys
      end

      def district_attorney(dist)
        dist.children[1].text = 'Cimarron' if dist.children[1].text.squish.eql? 'Cimmarron'
        {

          district: dist.children[1].text.squish,

          district_attorney: dist.children[3].text.squish,

          counties: dist.children[5].text.split(',').map(&:squish).select(&:present?)

        }
      end
    end
  end
end
