module Helpers
  def load_and_parse_fixture(file_path)
    html = File.read(file_path)
    Nokogiri::HTML.parse(html)
  end
end
