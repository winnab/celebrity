require_relative "app/routes/routes_map"
require_relative "app/routes/routes_definitions/game_overview"
require_relative "app/routes/routes_definitions/game_rules"
require_relative "app/routes/routes_definitions/index"
require_relative "app/routes/routes_definitions/invite"
require_relative "app/routes/routes_definitions/join"
require_relative "app/routes/routes_definitions/utils"

require_relative "app/services/game_store"
require_relative "app/services/invite_mailer"

require "better_errors"

class CelebrityApp < Sinatra::Base
  enable :sessions

  # TODO move to a different file?
  # runs once, sets structure
  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + "/app/views"
    set :public_dir, settings.root + "/app/public"
    set :session_secret, ENV["SESSION_KEY"]
    set :game_store, GameStore.new

  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  register Routes

  register Sinatra::CelebrityApp::Routing::GameOverview
  register Sinatra::CelebrityApp::Routing::GameRules
  register Sinatra::CelebrityApp::Routing::Index
  register Sinatra::CelebrityApp::Routing::Invite
  register Sinatra::CelebrityApp::Routing::Join
  register Sinatra::CelebrityApp::Routing::Utils

  helpers Sinatra::CelebrityApp::Services::InviteMailer
end
