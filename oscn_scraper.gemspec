lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oscn_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = 'oscn_scraper'
  spec.version       = OscnScraper::VERSION
  spec.authors       = ['Holden Mitchell']
  spec.email         = ['htmitchell90@gmail.com']

  spec.summary       = 'Scraper for the Oklahoma State Court Network'
  spec.homepage      = 'https://github.com/AyOK-Code/oscn_scraper'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.files         = ['lib/oscn_scraper.rb', 'lib/parsers/base_parser.rb']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 5.0.0'
  spec.add_dependency 'byebug', '>= 11.1.3'
  spec.add_development_dependency 'awesome_print', '>= 1.9.2'
  spec.add_dependency 'bundler', '>= 2.0'
  spec.add_dependency 'httparty', '>= 0.17'
  spec.add_dependency 'nokogiri', '>= 1.11'
  spec.add_dependency 'rake', '>= 10.0'
  spec.add_dependency 'yard', '~> 0.9.26'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.12'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.4'
  spec.add_dependency 'simplecov', '>= 0.21.2'
  spec.add_development_dependency 'webrick', '~> 1.7'
  spec.add_development_dependency 'webmock'
end
