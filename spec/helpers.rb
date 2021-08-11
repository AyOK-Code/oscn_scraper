module Helpers
  def load_and_parse_fixture(file_path)
    html = File.open(file_path).read
    Nokogiri::HTML.parse(html)
  end
end
