ENV["RACK_ENV"] = "test"

require "rubygems"
require "bundler"

require "sinatra/base"
require "sinatra/json"
require "active_model"

# TODO remove Bundler and explicitly require
Bundler.require()

require "./celebrity_app"
require "rack/test"
require "pry"

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do | config |
  # Use color in STDOUT
  config.color = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  # For RSpec 2.x
  RSpec.configure { |c| c.include RSpecMixin }
end
