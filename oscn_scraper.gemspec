lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "oscn_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "oscn_scraper"
  spec.version       = OscnScraper::VERSION
  spec.authors       = ["Holden Mitchell"]
  spec.email         = ["htmitchell90@gmail.com"]

  spec.summary       = %q{Scraper for the Oklahoma State Court Network }
  spec.homepage      = "https://github.com/AyOK-Code/oscn_scraper"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", "~> 1.11"
  spec.add_development_dependency "httparty", "~> 0.17"
  spec.add_development_dependency "byebug", "~> 11.1.3"
  spec.add_development_dependency "rubocop", "~> 1.12"
  spec.add_development_dependency "ruby-limiter", "~> 1.0.1"
  spec.add_development_dependency "simplecov", "~> 0.21.2"
  spec.add_development_dependency "activesupport", ">= 5.0.0"
end
