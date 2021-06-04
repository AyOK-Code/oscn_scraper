require 'bundler/setup'
require 'oscn_scraper'
require 'simplecov'
require './spec/helpers.rb'
SimpleCov.start

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.include Helpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.configure do |c|
  c.include Helpers
end
