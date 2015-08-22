ENV["RACK_ENV"] ||= "development"

require "rubygems"
require "bundler"

require "sinatra/base"
require "sinatra/json"

Bundler.require :default

require "./celebrity_app"

# use scss for stylesheets
require "sass/plugin/rack"
use Sass::Plugin::Rack

run CelebrityApp
