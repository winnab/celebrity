ENV["RACK_ENV"] = "test"

  require 'simplecov'
  SimpleCov.start

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

Capybara.app = CelebrityApp.new
