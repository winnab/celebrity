module Sinatra
  module CelebrityApp
    module Routing
      module Invite
        def self.registered(app)
          app.post "/invite" do
            if params["invite_email"].size > 0
              @players = session["players"] ||= []
              @players << params["invite_email"]
              Sinatra::CelebrityApp::Services::InviteMailer.send_mail params["invite_email"]
            end
            erb :game_overview
          end
        end
      end
    end
  end
end


