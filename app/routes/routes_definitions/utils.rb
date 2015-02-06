module Sinatra
  module CelebrityApp
    module Routing
      module Utils
        def self.registered(app)
          app.get "/styles/main.css" do
            scss :"../lib/styles/main.scss"
          end
        end
      end
    end
  end
end
