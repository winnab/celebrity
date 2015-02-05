module Sinatra
  module CelebrityApp
    module Routing
      module Routes
        def self.registered(app)
          app.get "/" do
            erb :index
          end

          app.get "/styles/main.css" do
            scss :"../lib/styles/main.scss"
          end

          app.post "/game_overview" do
            session["creator_name"] = params["creator_name"] unless params["creator_name"].nil?
            @name = session["creator_name"]
            erb :game_overview
          end

          app.post "/invite" do
            email_to_invite = params["invite_email"]
            @players = []
            if email_to_invite && email_to_invite.size > 0
              @players << email_to_invite
              Sinatra::CelebrityApp::Services::InviteMailer.send_mail email_to_invite
            end
            erb :game_overview
          end

          app.get "/how_to_play" do
            erb :how_to_play
          end
        end
      end
    end
  end
end
