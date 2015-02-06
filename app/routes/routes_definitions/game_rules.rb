module Sinatra
  module CelebrityApp
    module Routing
      module GameRules
        def self.registered(app)
          app.get "/how_to_play" do
            erb :how_to_play
          end
        end
      end
    end
  end
end




