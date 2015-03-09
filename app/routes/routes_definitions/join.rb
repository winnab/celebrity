require_relative "../../core/player"

module Sinatra
  module CelebrityApp
    module Routing
      module Join
        def self.registered(app)
          app.get "/join/:game_id" do
            if session["creator_name"] && session["creator_name"].size > 0
              @creator_name =  session["creator_name"]
            end
            erb :join
          end

          app.post "/join/:game_id" do
            game_id = params[:game_id]
            session["joined_player"] = {
              status: "joined",
              email: params["join_email"],
              clues: [
                params["clue_1"],
                params["clue_2"],
                params["clue_3"],
                params["clue_4"],
                params["clue_5"]
              ]
            }
            redirect to("/game_overview/#{game_id}")
          end
        end
      end
    end
  end
end


