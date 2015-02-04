ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require :default, ENV["RACK_ENV"].to_sym

require_relative "app/routes/routes_map"
require_relative "app/routes/routes_definitions/game_setup"
require_relative "app/services/invite_mailer"

class CelebrityApp < Sinatra::Base
  enable :sessions

  # runs once, sets structure
  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + '/app/views'
    set :public_dir, settings.root + '/app/public'
    set :session_secret, ENV["SESSION_KEY"]
  end

  register Sinatra::CelebrityApp::Routing::Routes
  register Sinatra::CelebrityApp::Routing::GameSetup

  helpers Sinatra::CelebrityApp::Services::InviteMailer

  run! if app_file == $0
end
