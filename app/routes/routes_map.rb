module Sinatra
  module CelebrityApp
    module Routing
      module RoutesMap
        def self.registered(app)
          puts "in app #{app}"
        end
      end
    end
  end
end
