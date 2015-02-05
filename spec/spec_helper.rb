ENV["RACK_ENV"] = "test"

# TODO remove Bundler and explicitly require
Bundler.require()

require "./celebrity_app"

RSpec.configure do | config |
  # Use color in STDOUT
  config.color = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end
