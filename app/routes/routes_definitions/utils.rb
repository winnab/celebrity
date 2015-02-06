module Sinatra
  module CelebrityApp
    module Routing
      module Utils
        def self.registered(app)
          app.get "/styles/main.css" do
            scss :"../lib/styles/main.scss"
          end

          app.get "/clear" do
            session.clear
            redirect to("/")
          end
        end
      end
    end
  end
end
