require "game"
require "pry"
describe Game do
  describe Game::Invite do
    let(:invite) { Game::Invite.new() }
    context "valid invite" do
      it "has a creator" do
        expect(invite).to respond_to(:created_by)
      end
    end

  end

  describe Game::Play do
    let(:playersObj) {
      ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"].map do | p |
        { name: p, clues: 5.times.each_with_object([]) { | i, obj | obj << "clue-#{i}"}  }
      end
     }
    let(:num_teams) { 2 }
    let(:game) { Game::Play.new(playersObj, num_teams) }

    context "valid game" do
      it "should create teams" do
        expect(game).to respond_to(:teams)
      end

      it "should assign players to teams evenly" do
        min_size, max_size = game.teams.map(&:length).minmax
        expect(max_size - min_size).to be <= 1
      end

      it "can start" do
        expect(game.can_start?).to be true
      end
    end

    context "invalid game" do
      context "having fewer than 6 players" do
        let(:game) { Game::Play.new(playersObj[0, 4], num_teams) }

        it "cannot be started" do
          expect(game.can_start?).to be false
        end
      end
      context "having an insufficient number of clues" do
        let(:playersObj) {
          ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"].map do | p |
            { name: p, clues: 3.times.each_with_object([]) { | i, obj | obj << "clue-#{i}"}  }
          end
         }

        it "cannot start" do
          expect(game.can_start?).to be false
        end
      end
    end

  end
end
