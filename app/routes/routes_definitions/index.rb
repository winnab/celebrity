module Sinatra
  module CelebrityApp
    module Routing
      module Index
        def self.registered(app)
          app.get "/" do
            @creator_name = session["creator_name"]
            erb :index
          end
        end
      end
    end
  end
end
