require "spec_helper"

describe CelebrityApp do
  let!(:game) { Game.new({name: "Test", clues: []})}

  describe "post /game_overview" do
    it "creates a game" do
      post "/game_overview", { creator_name: "test" }
      game = app.settings.game_store.list.last
      expect(last_response.status).to eql(302)
      expect(last_response.header["location"]).to include("/game_overview/#{game.id}")
    end
  end

  it "allows players to join" do
    app.settings.game_store.add(game)
    post "/join/#{game.id}"
    expect(last_response.status).to eql(302)
    expect(last_response.header["location"]).to include("/game_overview/#{game.id}")
  end

end
