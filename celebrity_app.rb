require_relative "app/routes/routes_map"
require_relative "app/routes/routes_definitions/game_overview"
require_relative "app/routes/routes_definitions/game_rules"
require_relative "app/routes/routes_definitions/index"
require_relative "app/routes/routes_definitions/invite"
require_relative "app/routes/routes_definitions/utils"
require_relative "app/services/invite_mailer"

class CelebrityApp < Sinatra::Base
  enable :sessions

  # TODO move to a different file?
  # runs once, sets structure
  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + "/app/views"
    set :public_dir, settings.root + "/app/public"
    set :session_secret, ENV["SESSION_KEY"]
  end

  register Routes

  register Sinatra::CelebrityApp::Routing::GameOverview
  register Sinatra::CelebrityApp::Routing::GameRules
  register Sinatra::CelebrityApp::Routing::Index
  register Sinatra::CelebrityApp::Routing::Invite
  register Sinatra::CelebrityApp::Routing::Utils

  helpers Sinatra::CelebrityApp::Services::InviteMailer
end
