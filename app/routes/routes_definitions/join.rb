require_relative "../../core/player"

module Sinatra
  module CelebrityApp
    module Routing
      module Join
        def self.registered(app)
          app.get "/join" do
            if session["creator_name"].size > 0
              @creator_name =  session["creator_name"]
            end
            erb :join
          end

          app.post "/join" do
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
            redirect to(:game_overview)
          end
        end
      end
    end
  end
end


