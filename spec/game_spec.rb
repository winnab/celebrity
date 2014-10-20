require "game"

describe Game do
  describe Game::Play do
    context "having six or more players" do
      let(:players) { ["winna", "neil", "chucky", "jessica", "richa", "deb"] }
      let(:num_teams) { 2 }
      let(:game) { Game::Play.new(players, num_teams) }
      it "should create teams" do
        game.should respond_to(:teams)

      end
    end
  end
end
