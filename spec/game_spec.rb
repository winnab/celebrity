require "game"
describe Game do
  describe Game::Play do
    context "having six or more players" do
      let(:players) { ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"] }
      let(:num_teams) { 2 }
      let(:game) { Game::Play.new(players, num_teams) }
      it "should create teams" do
        expect(game).to respond_to(:teams)
      end

      it "should assign players to teams evenly" do
        min_size, max_size = game.teams.map(&:length).minmax
        expect(max_size - min_size).to be <= 1
      end
    end
  end
end
