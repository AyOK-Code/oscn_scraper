require 'open-uri'
require 'byebug'

module OscnScraper
  module Parsers
    module OkBar
      # Pulls accurate data from the OK Bar Association
      # TODO: Figure out refresh schedule
      class AttorneyOkBar
        attr_accessor :base_url, :state_abreviation, :attorneys, :pagenum, :html

        def initialize(html)
          @attorneys = []
          @html = html
        end

        def self.perform(html)
          new(html).perform
        end

        def perform
          table = html.css('tr')
          table.each_with_index do |row, _index|
            next if row.children[1].text.squish.eql? 'Bar Number'

            attorneys << attorney(row)
          end
          attorneys
        end

        def attorney(row)
          {
            bar_number: row.children[1].text,
            first_name: row.children[2].text,
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
