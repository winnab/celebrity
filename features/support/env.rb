# See http://wiki.github.com/cucumber/cucumber/sinatra
# for more details about Sinatra with Cucumber

require File.dirname(__FILE__) + "/../../celebrity_app"

begin
  require "rspec/expectations"
rescue LoadError
  require "spec/expectations"
end
require "capybara/cucumber"
require "capybara/rspec"

Capybara.app = Sinatra::Application
