ENV["RACK_ENV"] ||= "development"

require "rubygems"
require "bundler"
require "better_errors"
require "pry"

Bundler.require()

require "./celebrity_app"

# use scss for stylesheets
require "sass/plugin/rack"
use Sass::Plugin::Rack

run CelebrityApp
