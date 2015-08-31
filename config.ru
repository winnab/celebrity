ENV["RACK_ENV"] ||= "development"

require "rubygems"
require "bundler"

Bundler.require()

require "./celebrity_app"

# use scss for stylesheets
require "sass/plugin/rack"
use Sass::Plugin::Rack

use Rack::Static, :urls => ['/scripts', '/styles'], :root => 'app/public'

run CelebrityApp
