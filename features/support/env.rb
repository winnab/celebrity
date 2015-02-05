ENV["RACK_ENV"] = "test"

# TODO remove Bundler and explicitly require
Bundler.require()

require File.dirname(__FILE__) + "/../../celebrity_app"

begin
  require "capybara/cucumber"
  require "capybara/rspec"
  require "cucumber/rspec/doubles"
  require "pry"
  require "rspec/expectations"
rescue LoadError
  require "spec/expectations"
end

# TODO is this right?
Capybara.app, _ = Rack::Builder.parse_file(
  File.expand_path(
    File.dirname(__FILE__) + "/../../config.ru",
    __FILE__
  )
)
