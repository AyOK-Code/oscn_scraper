require 'open-uri'
require 'byebug'

module OscnScraper
  module Parsers
    module OkBar
      # Pulls accurate data from the OK Bar Association
      # TODO: Figure out refresh schedule
      class AttorneyOkBar
        attr_accessor :base_url, :state_abreviation

        def initialize(state_abreviation = 'OK')
          @base_url = 'https://www.okbar.org/oba-member-search/?'
          @state_abreviation = state_abreviation
        end

        def self.perform(state_abreviation = 'OK')
          new(state_abreviation).perform
        end

        def perform
          url = "pagenum=1&sort%5B5%5D=desc&filter_11=#{state_abreviation}&mode=all"
          full_url = @base_url + url

          html = URI.open(full_url) # "#{base_url}#{url}"

          parsed_data = Nokogiri::HTML(html)
          parsed_data.css('.gv-table-view')
        end
      end
    end
  end
end
