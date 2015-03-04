require_relative '../controllers/joins_controller'

module Routes
  def self.registered(app)
    app.get "/join" do
      erb :join
    end

    app.post "/join" do
      JoinsController.new.join_game session, params
      redirect to(:game_overview)
    end
  end
end
