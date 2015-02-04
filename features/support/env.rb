# See http://wiki.github.com/cucumber/cucumber/sinatra
# for more details about Sinatra with Cucumber

require File.dirname(__FILE__) + "/../../celebrity_app"

begin
  require "rspec/expectations"
  require "cucumber/rspec/doubles"
rescue LoadError
  require "spec/expectations"
end
require "capybara/cucumber"
require "capybara/rspec"
require "pry"

Capybara.app = Sinatra::Application
