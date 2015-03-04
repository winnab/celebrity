require "spec_helper"

describe CelebrityApp do
  describe "post /game_overview" do
    it "creates a game" do
      game = double(:game, id: 1)
      expect(Game).to receive(:new).and_return(game)
      post "/game_overview", { creator_name: "test" }
      expect(last_response.status).to eql(302)
      expect(last_response.header["location"]).to include('/game_overview/1')
    end
  end
end
