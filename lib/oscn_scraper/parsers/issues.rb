module OscnScraper
  module Parsers
    # Description/Explanation of Issues class
    class Issues
      include OscnScraper::Parsers::Helpers
      attr_reader :counts_html

      def initialize(issues_html)
        @issues_html = issues_html
        @issues = { issues: [] }
      end

      def self.parse(issues_html)
        new(issues_html).parse
      end

      def parse
        parse_issues
      end

      private

      attr_accessor :issues, :issues_html

      def parse_issues
        return issues if issues_html.count < 1
        issue_table = issues_html.xpath('//h2[contains(@class, "issues")]/following-sibling::*[2]')
        dispositions_table = issues_html.xpath('//h2[contains(@class, "issues")]/following-sibling::*[3]')
        issues[:issues] << issue_object(issue_table, dispositions_table)

        issues
      end

      def issue_object(issue_table, dispositions_table)
        data = {
          number: issue_number(issue_table),
          issue_name: issue_name(issue_table),
          issue_code: issue_code(issue_table),
          filed_by: filed_by(issue_table),
          filed_on: filed_date(issue_table),
          parties: add_parties(dispositions_table)
        }
      end

      def add_parties(dispositions_table)
        parties = []
        dispositions_table.css('tbody tr').each do |row|
          return parties if party_name(row).blank?
          parties << disposition_object(row)
        end
        parties
      end

      def disposition_object(row)
          {
            name: party_name(row),
            disposition_on: disposition_on(row),
            verdict: verdict(row),
            verdict_detail: verdict_detail(row)
          }
      end

      def issue_number(table)
        table.css('tr td strong').text.split('#')[1].gsub('.', '').squish
      end

      def issue_name(table)
        table.css('tr td')[1].children[0].text.gsub('Issue:', '').split('(')[0].squish
      end

      def issue_code(table)
        data = table.css('tr td')[1].children[0].text.gsub('Issue:', '').split('(')[1]
        data.gsub(')', '').squish
      end

      def filed_by(table)
        table.css('tr td')[1].children[2].text.gsub('Filed By:', '').squish
      end

      def filed_date(table)
        table.css('tr td')[1].children[4].text.gsub('Filed Date:', '').squish
      end

      def disposition(row)
        row.css('td font[color="red"]').text.squish.gsub('Disposed: ', '')
      end

      def verdict(row)
        data = row.css('td')[2]&.children
        verdict = data.children.text.split(',').first&.gsub('Disposed:', '')&.squish
      end

      def verdict_detail(row)
        data = row.css('td')[2]&.children
        detail = data.children.text.split('.')[1]&.squish
      end

      def disposition_on(row)
        data = disposition(row).match(/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/).to_s
        parse_date(data)
      end

      def party_name(row)
        row.css('td')[1].text.gsub('Defendant:', '').squish
      end
    end
  end
end
