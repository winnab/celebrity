
require_relative "app/services/game_store"
require_relative "app/services/invite_store"
require_relative "app/services/invite_mailer"

class CelebrityApp < Sinatra::Base
  enable :sessions

  configure do
    set :root, File.dirname(__FILE__)
    set :views, settings.root + "/app/views"
    set :public_dir, settings.root + "/app/public"
    set :session_secret, ENV["SESSION_KEY"]
    set :game_store, GameStore.new
    set :invite_store, InviteStore.new
    set :invite_mailer, InviteMailer.new

  end

  end



end
