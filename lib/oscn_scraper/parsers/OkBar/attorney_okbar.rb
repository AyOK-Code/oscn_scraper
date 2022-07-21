require 'open-uri'
require 'byebug'

module OscnScraper
  module Parsers
    module OkBar
      # Pulls accurate data from the OK Bar Association
      # TODO: Figure out refresh schedule
      class AttorneyOkBar
        attr_accessor :base_url, :state_abreviation,:attorneys

        def initialize(state_abreviation = 'OK')
          @base_url = 'https://www.okbar.org/oba-member-search/?'
          @state_abreviation = state_abreviation
          @attorneys =[]
        end

        def self.perform(state_abreviation = 'OK')
          new(state_abreviation).perform
        end

        def perform

        pagenum = (1..547).to_a
        pagenum.each do |page|        
          url = "pagenum=#{page}&sort%5B5%5D=desc&filter_11=#{state_abreviation}&mode=all"
          full_url = @base_url + url

          html = URI.parse(full_url).open # "#{base_url}#{url}"

          parsed_data = Nokogiri::HTML(html)
          table = parsed_data.css('tr')
          table.each_with_index do |row,i|
            next if i.zero?
            
              attorneys << attorney(row)
              byebug
          end

        end
        end
        def attorney(row)
          {
            bar_number: row.children[1].text,
            first_name: row.children[2].text ,
            middle_name: row.children[3].text,
            last_name: row.children[4].text,
            city: row.children[5].text,
            state: row.children[6].text,
            member_type: row.children[7].text,
            member_status: row.children[8].text,
            admit_date: row.children[9].text
          }
        end
      end
    end
  end
end
