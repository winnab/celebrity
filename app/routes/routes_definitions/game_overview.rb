module Sinatra
  module CelebrityApp
    module Routing
      module GameOverview
        def self.registered(app)
          app.post "/game_overview" do
            @players = session["players"] ||= []
            if params["creator_name"].size > 0
              @creator_name = session["creator_name"] = params["creator_name"]
              @players << @creator_name
            end
            erb :game_overview
          end

          app.get "/game_overview" do
            @creator_name = session["creator_name"]
            @players = session["players"] ||= []

            if !!session["joined_player"]
              @joined_player = session["joined_player"]
              @players << session["joined_player"]
            end

            erb :game_overview
          end
        end
      end
    end
  end
end


